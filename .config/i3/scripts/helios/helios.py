#!/usr/bin/env python3
import argparse
import subprocess
from pathlib import Path

from fastapi import FastAPI
from fastapi.responses import PlainTextResponse
from starlette.middleware.cors import CORSMiddleware
import uvicorn


DEFAULTS_DIRECTORY = Path(__file__).parent / Path("defaults")
UTILITY_WORKSPACE = "0:Utility"


# ==== SERVER ======================================================================================
# ---- FastAPI Instance ----------------------------------------------------------------------------
app = FastAPI()
app.add_middleware(CORSMiddleware,
                   allow_origins=["127.0.0.1"],
                   allow_methods=["*"],
                   allow_headers=["*"])
# --------------------------------------------------------------------------------------------------

# ---- Workspace Setup -----------------------------------------------------------------------------
group_names = ["F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"]
group_ids = {}
for i, group_name in enumerate(group_names):
    group_ids[group_name] = i

workspace_names = ["\\`", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="]
workspace_ids = {}
for i, workspace_name in enumerate(workspace_names):
    workspace_ids[workspace_name] = i

working_sets = {}
default_working_sets = []
default_working_sets_filepath = DEFAULTS_DIRECTORY / Path("working_sets")
if default_working_sets_filepath.exists():
    with open(default_working_sets_filepath, "r") as infile:
        for i, working_set in enumerate([x.strip() for x in infile.readlines()]):
            working_sets[working_set.lower()] = {"display_name": working_set, "set_id": i}
            default_working_sets.append(working_set)

state = {
    "working_set": "general",
    "group": group_names[0],
    "workspace": workspace_names[0],
    "is_utility": False,
}


proc = subprocess.Popen(f"notify-send 'Helios is starting up'",
                        stdout=subprocess.PIPE,
                        shell=True)
# --------------------------------------------------------------------------------------------------


# ---- Endpoints -----------------------------------------------------------------------------------
@app.get("/")
def index():
    #for working_set_name, _ in get_working_sets():
    #    for group_name in group_names:
    #        for workspace_name in workspace_names:
    #            print(get_workspace_name(working_set_name, group_name, workspace_name))
    print(get_active_working_sets())
    return ""

# Workspace
@app.get("/workspace/{workspace_id}")
async def switch_workspace(workspace_id: int):
    state["workspace"] = workspace_names[workspace_id]
    state["is_utility"] = False
    workspace_name_global = get_workspace_name_by_state(state)
    i3(f"workspace \"{workspace_name_global}\"")


@app.post("/workspace/{workspace_id}")
async def move_to_workspace(workspace_id: int):
    workspace_name_global = get_workspace_name(state["working_set"],
                                               state["group"],
                                               workspace_names[workspace_id])
    i3(f"move container to workspace \"{workspace_name_global}\"")


# Group
@app.get("/group/{group_id}")
async def switch_group(group_id: int):
    state["group"] = group_names[group_id]
    state["is_utility"] = False
    workspace_name_global = get_workspace_name_by_state(state)
    i3(f"workspace \"{workspace_name_global}\"")


@app.post("/group/{group_id}")
async def move_to_group(group_id: int):
    workspace_name_global = get_workspace_name(state["working_set"],
                                               group_names[group_id],
                                               state["workspace"])
    i3(f"move container to workspace \"{workspace_name_global}\"")


@app.get("/group/info/")
async def get_group_info():
    workspace_name = i3('-t get_workspaces | jq \'.[] | select(.focused == true).name\'').decode()
    workspace_name_parts = workspace_name.split(":")
    group_name = "general" if len(workspace_name_parts) < 3 else workspace_name_parts[1].lower()
    print(group_name)
    return PlainTextResponse(content=group_name)


# Working Set
@app.get("/working_set/{working_set_display_name}")
async def switch_working_set(working_set_display_name: str):
    working_set_key = working_set_display_name.lower()
    if working_set_key not in working_sets:
        working_sets[working_set_key] = {
            "display_name": working_set_display_name,
            "set_id": get_working_sets()[-1][1]["set_id"] + 1,
        }
    print(working_sets)
    state["working_set"] = working_set_key
    state["is_utility"] = False
    workspace_name_global = get_workspace_name_by_state(state)
    i3(f"workspace \"{workspace_name_global}\"")


@app.post("/working_set/{working_set_display_name}")
async def move_to_working_set(working_set_display_name: str):
    working_set_key = working_set_display_name.lower()
    if working_set_key not in working_sets:
        working_sets[working_set_key] = {
            "display_name": working_set_display_name,
            "set_id": get_working_sets()[-1][1]["set_id"] + 1,
        }
    workspace_name_global = get_workspace_name(working_set_key,
                                               state["group"],
                                               state["workspace"])
    i3(f"move container to workspace \"{workspace_name_global}\"")


@app.get("/working_set/")
async def switch_working_set_with_menu():
    active_working_sets = "\n".join([x[1]["display_name"] for x in get_active_working_sets()])
    proc = subprocess.Popen(f"echo '{active_working_sets}' | rofi -dmenu -i -p 'Switch Working Set'",
                            stdout=subprocess.PIPE,
                            shell=True)
    out, _ = proc.communicate()
    working_set = out.decode().strip()
    if len(working_set) != 0:
        await switch_working_set(working_set)


@app.post("/working_set/")
async def move_to_working_set_with_menu():
    active_working_sets = "\n".join([x[1]["display_name"] for x in get_active_working_sets()])
    proc = subprocess.Popen(f"echo '{active_working_sets}' | rofi -dmenu -i -p 'Move to Working Set'",
                            stdout=subprocess.PIPE,
                            shell=True)
    out, _ = proc.communicate()
    working_set = out.decode().strip()
    if len(working_set) != 0:
        await move_to_working_set(working_set)


@app.get("/utility/")
async def switch_to_util():
    if state["is_utility"]:
        state["is_utility"] = False
        await switch_workspace(workspace_ids[state["workspace"]])
    else:
        state["is_utility"] = True
        i3(f"workspace {UTILITY_WORKSPACE}")


@app.post("/utility/")
async def move_to_util():
    i3(f"move container to workspace {UTILITY_WORKSPACE}")
# --------------------------------------------------------------------------------------------------
# ==================================================================================================


# ==== HELPERS =====================================================================================
def get_working_set_names() -> list[str]:
    return [ws[0] for ws in get_working_sets()]


def get_working_sets() -> list:
    return sorted([ws for ws in working_sets.items()], key=lambda x: x[1]["set_id"])


def get_workspace_name_by_state(state: dict) -> str:
    return get_workspace_name(state["working_set"], state["group"], state["workspace"])


def get_workspace_name(working_set_name: str, group_name: str, workspace_name: str) -> str:
    working_set = working_sets[working_set_name.lower()]
    group_id = group_ids[group_name]
    workspace_id_local = workspace_ids[workspace_name]

    workspace_id_global = (1
                           + (working_set["set_id"]*len(group_names)*len(workspace_names))
                           + (group_id*len(workspace_names)) + workspace_id_local)

    working_set_display_name = (
        f"{working_set['display_name']}:"
        if working_set_name != "general"
        else ""
    )
    return f"{workspace_id_global}:{working_set_display_name}{group_name}_{workspace_name}"


def get_active_working_sets() -> list[dict]:
    workspaces = i3("-t get_workspaces | jq -r '.[].name'")
    workspaces = [x.strip() for x in workspaces.decode().split("\n") if len(x.strip()) != 0]
    print(workspaces)
    # DEBUG
    workspaces = [f"000:{x}" if not x[0].isdigit() else x for x in workspaces]
    # END DEBUG
    workspaces = [x.split(":")[1].lower() for x in workspaces]
    active_workspaces = set(workspaces + [x.lower() for x in default_working_sets])
    return [x for x in get_working_sets() if x[0] in active_workspaces]


def i3(cmd: str):
    proc = subprocess.Popen(f"i3-msg {cmd}", stdout=subprocess.PIPE, shell=True)
    out, err = proc.communicate()
    if err is not None:
        print("ERROR")
        print(err)
    return out
# ==================================================================================================


# ==== RUN SERVER ==================================================================================
def run_server(args: argparse.Namespace):
    uvicorn.run("helios:app",
                host="127.0.0.1",
                port=args.port,
                reload=args.reload,
                workers=1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", type=int, default=7777)
    parser.add_argument("--reload", action="store_true")

    args = parser.parse_args()
    run_server(args)
# ==================================================================================================
