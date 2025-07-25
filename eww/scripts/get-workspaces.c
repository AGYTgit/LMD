#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <json-c/json.h>
#include <limits.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <monitor_name> <reversed (0/1)>\n", argv[0]);
        return 1;
    }
    char *monitor = argv[1];
    int reversed = atoi(argv[2]);


	// get all current workspaces
	char current_command[1024];
	snprintf(current_command, sizeof(current_command),
		"hyprctl workspaces -j | jq -c '[.[] | {id: .id, windows: .windows, monitor: .monitor} | select(.monitor == \"%s\")]'", 
		monitor);
    FILE *fp_c = popen(current_command, "r");
    if (fp_c == NULL) {
        fprintf(stderr, "Failed to run current_command\n");
        return 1;
    }
    char workspaces_current[1024];
    if (fgets(workspaces_current, sizeof(workspaces_current), fp_c) == NULL) {
        fprintf(stderr, "Failed to read workspaces_current\n");
        fclose(fp_c);
		return 1;
    }
    fclose(fp_c);


	// get all possible workspaces
	char all_command[1024];
	snprintf(all_command, sizeof(all_command),
		"hyprctl workspacerules -j | jq -c '[.[] | {id: .workspaceString, monitor: .monitor} | select(.monitor == \"%s\")]%s'", 
		monitor, reversed ? " | reverse" : ""
	);
    FILE *fp = popen(all_command, "r");
    if (fp == NULL) {
        fprintf(stderr, "Failed to run all_command\n");
        return 1;
    }
    char workspaces_all[1024];
    if (fgets(workspaces_all, sizeof(workspaces_all), fp) == NULL) {
        fprintf(stderr, "Failed to read workspaces_all\n");
        fclose(fp_c);
		return 1;
    }
    fclose(fp);


    // Parse the JSON arrays
    struct json_object *workspaces_current_json = json_tokener_parse(workspaces_current);
    struct json_object *workspaces_all_json = json_tokener_parse(workspaces_all);

    if (workspaces_current_json == NULL || workspaces_all_json == NULL) {
        fprintf(stderr, "Failed to parse JSON\n");
        return 1;
    }


	// get active workspace's id
	const char *active_command = "hyprctl activeworkspace -j | jq -r '.id'";
	FILE *fp2 = popen(active_command, "r");
	if (fp2 == NULL) {
		fprintf(stderr, "Failed to run active_command\n");
		return 1;
	}
	int workspace_active_id = -1;
	if (fscanf(fp2, "%d", &workspace_active_id) != 1) {
		fprintf(stderr, "Failed to read active workspace ID\n");
		fclose(fp2);
		return 1;
	}
	fclose(fp2);


    // get max id from workspaces_current
    int max_id = INT_MIN;
    int array_len = json_object_array_length(workspaces_current_json);

    for (int i = 0; i < array_len; i++) {
        struct json_object *workspace_current_obj = json_object_array_get_idx(workspaces_current_json, i);
        int id = json_object_get_int(json_object_object_get(workspace_current_obj, "id"));

        if (id > max_id) {
            max_id = id;
        }
    }


    // fill missing workspaces (id <= max_id) in workspaces_current_json
    int workspaces_all_len = json_object_array_length(workspaces_all_json);
    for (int i = 0; i < workspaces_all_len; i++) {
        struct json_object *workspace_all_obj = json_object_array_get_idx(workspaces_all_json, i);
        int id = json_object_get_int(json_object_object_get(workspace_all_obj, "id"));

        if (id <= max_id) {
            int found = 0;
            for (int j = 0; j < array_len; j++) {
                struct json_object *workspace_current_obj = json_object_array_get_idx(workspaces_current_json, j);
                int current_id = json_object_get_int(json_object_object_get(workspace_current_obj, "id"));

                if (current_id == id) {
                    // copy the "windows" count from the current workspace
                    struct json_object *windows_obj = json_object_object_get(workspace_current_obj, "windows");
                    json_object_object_add(workspace_all_obj, "windows", windows_obj);
                    found = 1;
                    break;
                }
            }

            if (!found) {
                // add missing workspace with windows = 0
                json_object_object_add(workspace_all_obj, "windows", json_object_new_int(0));
            }
        }
    }

    // remove any workspace with id > max_id from workspaces_all_json
    for (int i = workspaces_all_len - 1; i >= 0; i--) {
        struct json_object *workspace_all_obj = json_object_array_get_idx(workspaces_all_json, i);
        int id = json_object_get_int(json_object_object_get(workspace_all_obj, "id"));

        if (id > max_id) {
            json_object_array_del_idx(workspaces_all_json, i, 1);
        }
    }

    // mark active workspace in workspaces_all_json
    workspaces_all_len = json_object_array_length(workspaces_all_json);  // update length after deletion
    for (int i = 0; i < workspaces_all_len; i++) {
        struct json_object *workspace_all_obj = json_object_array_get_idx(workspaces_all_json, i);
        int id = json_object_get_int(json_object_object_get(workspace_all_obj, "id"));

        if (id == workspace_active_id) {
            json_object_object_add(workspace_all_obj, "active", json_object_new_boolean(1));
        } else {
            json_object_object_add(workspace_all_obj, "active", json_object_new_boolean(0));
        }
    }

    printf("%s\n", json_object_to_json_string_ext(workspaces_all_json, JSON_C_TO_STRING_PLAIN));

    // clean up
    json_object_put(workspaces_all_json);
    json_object_put(workspaces_current_json);

    return 0;
}
