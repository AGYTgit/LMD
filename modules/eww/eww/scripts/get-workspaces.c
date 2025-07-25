#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <json-c/json.h>
#include <limits.h> // For INT_MIN, INT_MAX

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <monitor_name> <dynamicVisibility (0/1)> <reversed (0/1)>\n", argv[0]);
        return 1;
    }
    char *monitor = argv[1];
    int dynamicVisibility = atoi(argv[2]);
    int reversed = atoi(argv[3]);

    // get all current workspaces (those with active windows or recently visited) for the SPECIFIED MONITOR
    char current_command[1024];
    snprintf(current_command, sizeof(current_command),
        "hyprctl workspaces -j | jq -c '[.[] | {id: .id, windows: .windows, monitor: .monitor} | select(.monitor == \"%s\")]'", monitor);
    FILE *fp_c = popen(current_command, "r");
    if (fp_c == NULL) {
        fprintf(stderr, "Failed to run current_command\n");
        return 1;
    }
    char workspaces_current[1024];
    if (fgets(workspaces_current, sizeof(workspaces_current), fp_c) == NULL) {
        strncpy(workspaces_current, "[]", sizeof(workspaces_current));
    }
    fclose(fp_c);

    // get all possible workspaces defined by rules for the SPECIFIED MONITOR, sorted numerically by ID
    char all_command[1024];
    snprintf(all_command, sizeof(all_command),
        "hyprctl workspacerules -j | jq -c '[.[] | {id: .workspaceString | tonumber, monitor: .monitor} | select(.monitor == \"%s\")] | sort_by(.id)'",
        monitor);
    FILE *fp = popen(all_command, "r");
    if (fp == NULL) {
        fprintf(stderr, "Failed to run all_command\n");
        return 1;
    }
    char workspaces_all[1024];
    if (fgets(workspaces_all, sizeof(workspaces_all), fp) == NULL) {
        strncpy(workspaces_all, "[]", sizeof(workspaces_all));
    }
    fclose(fp);

    // Parse the JSON arrays
    struct json_object *workspaces_current_json = json_tokener_parse(workspaces_current);
    struct json_object *workspaces_all_json = json_tokener_parse(workspaces_all);

    if (workspaces_current_json == NULL || workspaces_all_json == NULL) {
        fprintf(stderr, "Failed to parse JSON\n");
        if (workspaces_current_json) json_object_put(workspaces_current_json);
        if (workspaces_all_json) json_object_put(workspaces_all_json);
        return 1;
    }

    // Get GLOBAL active workspace ID (still needed for 'active' state in output)
    const char *active_command = "hyprctl activeworkspace -j | jq -r '.id'";
    FILE *fp2 = popen(active_command, "r");
    if (fp2 == NULL) {
        fprintf(stderr, "Failed to run active_command\n");
        json_object_put(workspaces_current_json);
        json_object_put(workspaces_all_json);
        return 1;
    }
    int workspace_active_id = -1;
    if (fscanf(fp2, "%d", &workspace_active_id) != 1) {
        // Handle case where active workspace ID might not be immediately available or parsable
    }
    fclose(fp2);

    // Determine min/max allowed workspace IDs for this specific monitor from workspacerules
    int workspaces_all_len = json_object_array_length(workspaces_all_json);
    int min_allowed_id_for_this_monitor = 1; // Default fallback
    int max_allowed_id_for_this_monitor = 10; // Default fallback (common Hyprland default)

    if (workspaces_all_len > 0) {
        min_allowed_id_for_this_monitor = json_object_get_int(json_object_object_get(json_object_array_get_idx(workspaces_all_json, 0), "id"));
        max_allowed_id_for_this_monitor = json_object_get_int(json_object_object_get(json_object_array_get_idx(workspaces_all_json, workspaces_all_len - 1), "id"));
    }
    
    struct json_object *temp_filtered_workspaces = json_object_new_array();
    int current_array_len = json_object_array_length(workspaces_current_json);

    if (dynamicVisibility) {
        int min_active_or_windowed_id = INT_MAX; // This will be our 'lowest ws'

        // Find the lowest ID among all workspaces reported by hyprctl workspaces -j for this monitor
        // This includes active empty workspaces and those with windows.
        for (int i = 0; i < current_array_len; i++) {
            struct json_object *workspace_current_obj = json_object_array_get_idx(workspaces_current_json, i);
            int id = json_object_get_int(json_object_object_get(workspace_current_obj, "id"));

            if (id < min_active_or_windowed_id) {
                min_active_or_windowed_id = id;
            }
        }

        int final_min_id;
        int final_max_id;

        if (min_active_or_windowed_id == INT_MAX) { 
            // Case: No workspaces reported for this monitor at all (completely blank monitor)
            // Show the full allowed range by default.
            final_min_id = min_allowed_id_for_this_monitor;
            final_max_id = max_allowed_id_for_this_monitor;
        } else {
            // Case: At least one workspace is reported (active or has windows)
            // Rule: Display from the lowest reported ID up to the max allowed for this monitor.
            final_min_id = min_active_or_windowed_id;
            final_max_id = max_allowed_id_for_this_monitor;
        }

        // Final clamping to ensure bounds are within the monitor's allowed rules
        if (final_min_id < min_allowed_id_for_this_monitor) final_min_id = min_allowed_id_for_this_monitor;
        if (final_max_id > max_allowed_id_for_this_monitor) final_max_id = max_allowed_id_for_this_monitor;

        // Populate temp_filtered_workspaces based on the calculated final range
        for (int i = 0; i < workspaces_all_len; i++) {
            struct json_object *workspace_all_obj = json_object_array_get_idx(workspaces_all_json, i);
            int id = json_object_get_int(json_object_object_get(workspace_all_obj, "id"));

            if (id >= final_min_id && id <= final_max_id) {
                int windows_count = 0;
                for (int j = 0; j < current_array_len; j++) {
                    struct json_object *current_ws_obj = json_object_array_get_idx(workspaces_current_json, j);
                    int current_id = json_object_get_int(json_object_object_get(current_ws_obj, "id"));
                    if (current_id == id) {
                        windows_count = json_object_get_int(json_object_object_get(current_ws_obj, "windows"));
                        break;
                    }
                }
                struct json_object *new_ws_obj = json_object_new_object();
                json_object_object_add(new_ws_obj, "id", json_object_new_int(id));
                json_object_object_add(new_ws_obj, "windows", json_object_new_int(windows_count));
                json_object_array_add(temp_filtered_workspaces, new_ws_obj);
            }
        }
    } else { // dynamicVisibility is false, show ALL workspaces defined by rules for THIS MONITOR
        for (int i = 0; i < workspaces_all_len; i++) {
            struct json_object *workspace_all_obj = json_object_array_get_idx(workspaces_all_json, i);
            int id = json_object_get_int(json_object_object_get(workspace_all_obj, "id"));

            int windows_count = 0;
            for (int j = 0; j < current_array_len; j++) {
                struct json_object *current_ws_obj = json_object_array_get_idx(workspaces_current_json, j);
                int current_id = json_object_get_int(json_object_object_get(current_ws_obj, "id"));
                if (current_id == id) {
                    windows_count = json_object_get_int(json_object_object_get(current_ws_obj, "windows"));
                    break;
                }
            }
            struct json_object *new_ws_obj = json_object_new_object();
            json_object_object_add(new_ws_obj, "id", json_object_new_int(id));
            json_object_object_add(new_ws_obj, "windows", json_object_new_int(windows_count));
            json_object_array_add(temp_filtered_workspaces, new_ws_obj);
        }
    }

    struct json_object *final_workspaces_array = json_object_new_array();
    int temp_array_len = json_object_array_length(temp_filtered_workspaces);

    if (reversed) {
        for (int i = temp_array_len - 1; i >= 0; i--) {
            struct json_object *workspace_obj = json_object_array_get_idx(temp_filtered_workspaces, i);
            int id = json_object_get_int(json_object_object_get(workspace_obj, "id"));

            // Mark active workspace, ONLY IF it's the global active AND it's allowed on this monitor
            if (id == workspace_active_id && 
                id >= min_allowed_id_for_this_monitor && 
                id <= max_allowed_id_for_this_monitor) {
                json_object_object_add(workspace_obj, "active", json_object_new_boolean(1));
            } else {
                json_object_object_add(workspace_obj, "active", json_object_new_boolean(0));
            }
            json_object_array_add(final_workspaces_array, json_object_get(workspace_obj));
        }
    } else {
        for (int i = 0; i < temp_array_len; i++) {
            struct json_object *workspace_obj = json_object_array_get_idx(temp_filtered_workspaces, i);
            int id = json_object_get_int(json_object_object_get(workspace_obj, "id"));

            // Mark active workspace, ONLY IF it's the global active AND it's allowed on this monitor
            if (id == workspace_active_id && 
                id >= min_allowed_id_for_this_monitor && 
                id <= max_allowed_id_for_this_monitor) {
                json_object_object_add(workspace_obj, "active", json_object_new_boolean(1));
            } else {
                json_object_object_add(workspace_obj, "active", json_object_new_boolean(0));
            }
            json_object_array_add(final_workspaces_array, json_object_get(workspace_obj));
        }
    }

    printf("%s\n", json_object_to_json_string_ext(final_workspaces_array, JSON_C_TO_STRING_PLAIN));

    json_object_put(workspaces_current_json);
    json_object_put(workspaces_all_json);
    json_object_put(temp_filtered_workspaces);
    json_object_put(final_workspaces_array);

    return 0;
}
