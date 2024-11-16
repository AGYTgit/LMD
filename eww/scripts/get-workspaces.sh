#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    // Validate input
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <monitor_name> <reverse(1/0)>\n", argv[0]);
        return 1;
    }

    // Store input
    const char *monitor = argv[1];
    int reverse_flag = atoi(argv[2]); // Convert the string "1" or "0" to integer

    // Construct the command string to fetch workspaces based on monitor and reverse flag
    char command[1024];
    snprintf(command, sizeof(command), 
             "hyprctl workspacerules -j | jq -c '[.[] | select(.monitor == \"%s\") | {id: .workspaceString | tonumber, monitor: .monitor}]%s'", 
             monitor, reverse_flag == 1 ? " | reverse" : "");

    // Run the command and capture the output into a file stream
    FILE *fp = popen(command, "r");
    if (fp == NULL) {
        perror("Failed to run command");
        return 1;
    }

    // Read the command output into a buffer
    char workspaces_all[1024];
    if (fgets(workspaces_all, sizeof(workspaces_all), fp) == NULL) {
		fclose(fp);
		return 1;
	}

	// Capture active workspace ID
	char active_workspace_command[] = "hyprctl activeworkspace -j | jq -r '.id'";
	FILE *active_fp = popen(active_workspace_command, "r");
	if (active_fp == NULL) {
		perror("Failed to get active workspace");
		fclose(fp);
		return 1;
	}
	
	// Read the active workspace ID
	char active_workspace_id[3];
	fgets(active_workspace_id, sizeof(active_workspace_id), active_fp);
	fclose(active_fp);

	// construct the filter to add "active" field to the JSON
	char active_filter[1024];
	snprintf(active_filter, sizeof(active_filter),
			 ".[] | select(.id == %s) |= . + {active: true} | select(.id != %s) |= . + {active: false}",
			 active_workspace_id, active_workspace_id);

	// modify JSON to add "active"
	char final_command[2048];
	snprintf(final_command, sizeof(final_command),
			 "echo '%s' | jq -c '[%s]'", workspaces_all, active_filter);

	// run the final command and print the result
	FILE *final_fp = popen(final_command, "r");
	if (final_fp == NULL) {
		perror("Failed to run final command");
		fclose(fp);
		return 1;
	}

	// print the modified JSON
	char output[2048];
	while (fgets(output, sizeof(output), final_fp) != NULL) {
		printf("%s", output);
	}

    // close the file stream
    fclose(fp);

    return 0;
}
