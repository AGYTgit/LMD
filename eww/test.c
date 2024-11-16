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

    // Example of workspaces currently in use
    char *workspaces_current = "[ \
        {\"id\": 1, \"windows\": 2}, \
        {\"id\": 3, \"windows\": 1} \
    ]";

    // Example of all possible workspaces
    char *workspaces_all = "[ \
        {\"id\": 1}, \
        {\"id\": 2}, \
        {\"id\": 3}, \
        {\"id\": 4}, \
        {\"id\": 5} \
    ]";

    // Parse the JSON arrays
    struct json_object *workspaces_current_json = json_tokener_parse(workspaces_current);
    struct json_object *workspaces_all_json = json_tokener_parse(workspaces_all);

    if (workspaces_current_json == NULL || workspaces_all_json == NULL) {
        fprintf(stderr, "Failed to parse JSON\n");
        return 1;
    }

    // Example active workspace ID (this should come from hyprctl activeworkspace -j)
    int workspace_active_id = 3;

    // Get max ID from workspaces_current
    int max_id = INT_MIN;
    int array_len = json_object_array_length(workspaces_current_json);

    for (int i = 0; i < array_len; i++) {
        struct json_object *workspace_current_obj = json_object_array_get_idx(workspaces_current_json, i);
        int id = json_object_get_int(json_object_object_get(workspace_current_obj, "id"));

        if (id > max_id) {
            max_id = id;
        }
    }

    // Fill missing workspaces (id <= max_id) in workspaces_current_json
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
                    // Copy the "windows" count from the current workspace
                    struct json_object *windows_obj = json_object_object_get(workspace_current_obj, "windows");
                    json_object_object_add(workspace_all_obj, "windows", windows_obj);
                    found = 1;
                    break;
                }
            }

            if (!found) {
                // Add missing workspace with windows = 0
                json_object_object_add(workspace_all_obj, "windows", json_object_new_int(0));
            }
        }
    }

    // Remove any workspace with id > max_id from workspaces_all_json
    for (int i = workspaces_all_len - 1; i >= 0; i--) {
        struct json_object *workspace_all_obj = json_object_array_get_idx(workspaces_all_json, i);
        int id = json_object_get_int(json_object_object_get(workspace_all_obj, "id"));

        if (id > max_id) {
            json_object_array_del_idx(workspaces_all_json, i, 1);
        }
    }

    // Mark active workspace in workspaces_all_json
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

    // Clean up
    json_object_put(workspaces_all_json);
    json_object_put(workspaces_current_json);

    return 0;
}
