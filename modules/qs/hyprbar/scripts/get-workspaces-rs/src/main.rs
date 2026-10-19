use hyprland::data::{Workspace, Workspaces, Monitors};
use hyprland::shared::{HyprData, HyprDataActive, HyprDataVec};
use serde::Serialize;
use std::env;

#[derive(Serialize)]
struct WorkspaceOut {
    id: i32,
    name: String,
    windows: i32,
    active: bool,
    occupied: bool,
    dummy: bool,
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 4 {
        eprintln!("Usage: {} <group_name> <dynamic_visibility 0/1> <reversed 0/1>", args[0]);
        return;
    }

    let group_name = &args[1];
    let dynamic_visibility = args[2] == "1";
    let reversed = args[3] == "1";

    let all_workspaces = Workspaces::get().map(|w| w.to_vec()).unwrap_or_default();
    let all_monitors = Monitors::get().map(|m| m.to_vec()).unwrap_or_default();
    let active_ws = Workspace::get_active();
    let active_ws_id = active_ws.as_ref().map(|w| w.id).unwrap_or(-1);
    let active_ws_name = active_ws.map(|w| w.name).unwrap_or_default();

    let visible_workspace_ids: Vec<i32> = all_monitors
        .iter()
        .map(|m| m.active_workspace.id)
        .collect();

    let mut output_list: Vec<WorkspaceOut> = Vec::new();

    match group_name.as_str() {
        "left" | "right" => {
            let (min_range, max_range) = if group_name == "left" { (1, 5) } else { (6, 10) };
            let range = min_range..=max_range;
            
            let min_occupied_in_group = all_workspaces.iter()
                .filter(|w| range.contains(&w.id) && w.windows > 0)
                .map(|w| w.id)
                .min()
                .unwrap_or(max_range + 1);

            let monitor_visible_in_group = visible_workspace_ids.iter()
                .filter(|&&id| range.contains(&id))
                .min()
                .cloned()
                .unwrap_or(max_range + 1);
            
            let visibility_threshold = min_occupied_in_group.min(monitor_visible_in_group);

            for id in range {
                let ws_data = all_workspaces.iter().find(|w| w.id == id);
                let windows = ws_data.map(|w| w.windows as i32).unwrap_or(0);
                
                let is_active = id == active_ws_id;
                let is_visible = visible_workspace_ids.contains(&id);
                let is_occupied = windows > 0;

                if !dynamic_visibility || id >= visibility_threshold || is_occupied {
                    output_list.push(WorkspaceOut {
                        id,
                        name: id.to_string(),
                        windows,
                        active: is_active,
                        occupied: is_occupied,
                        dummy: !is_visible && !is_occupied,
                    });
                }
            }
        }
        "special" => {
            for ws in all_workspaces.iter().filter(|w| w.id < 0 || w.name.starts_with("special:")) {
                let is_active = ws.name == active_ws_name;
                let is_occupied = ws.windows > 0;
                
                output_list.push(WorkspaceOut {
                    id: ws.id,
                    name: ws.name.replace("special:", ""),
                    windows: ws.windows as i32,
                    active: is_active,
                    occupied: is_occupied,
                    dummy: false,
                });
            }
        }
        _ => {}
    }

    if reversed {
        output_list.reverse();
    }

    if let Ok(json) = serde_json::to_string(&output_list) {
        println!("{}", json);
    }
}
