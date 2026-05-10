#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jan 17 18:23:04 2026

@author: gllore
"""

import os
import sys
from pathlib import Path
from typing import Any, Dict, Optional

# tests follow
# env = myProject_config()
# pp = ProjectPaths(env)
# paths = pp.build()
# print(paths)
# print(pp.DATA_SEISMIC_BIN)     # attribute access
# print(pp.paths["DATA_SEISMIC_BIN"])  # dict access still works
    

# confirm that environment variables are correctly set
def _get_env_path(varname: str) -> Path:
    """Get an environment variable as a Path, with a clear error if missing."""
    value = os.environ.get(varname)
    if not value:
        raise RuntimeError(f"{varname} is not set")
    return Path(value)

# turn into Path objects
def _as_path(x: Any, name: str) -> Path:
    """Coerce x to a Path or raise a helpful error."""
    if isinstance(x, Path):
        return x
    if isinstance(x, str) and x:
        return Path(x)
    raise ValueError(f"{name} must be a non-empty path-like value, got {x!r}")


def _as_str(x: Any, name: str) -> str:
    """Coerce x to a string or raise if missing."""
    if x is None:
        raise ValueError(f"{name} is missing in Project_config")
    return str(x)


class ProjectPaths:
    """
    Build derived project paths from an existing Project_config instance.

    Usage:
        env = Project_config()
        pp = ProjectPaths(env)
        paths = pp.build()
        print(paths["DATA_SEISMIC_BIN"])
        print(pp.DATA_SEISMIC_BIN)     # attribute access
    """

    def __init__(self, env: Any):
        self.env = env
        self.paths: Dict[str, Any] = {}
        self._exported_keys = set()

    def build(self) -> Dict[str, Any]:
        """
        Build and cache the derived paths dictionary.
        Returns the cached dictionary (computed once per instance).
        """
        # do not rebuild paths dictionary if it already exists in memory
        if self.paths:
            return self.paths

        # Start with a copy of the project config
        Project_config = dict(self.env.project_config)

        # Validate required keys exist
        required = ["PROJECT_HOME", "site", "date", "component", "line"]
        missing = [k for k in required if k not in Project_config]
        if missing:
            raise KeyError(f"Missing required keys in Project_config: {missing}")

        # Coerce types for path building
        project_home = _as_path(Project_config["PROJECT_HOME"], "PROJECT_HOME")
        site         = _as_str(Project_config["site"], "site")
        date         = _as_str(Project_config["date"], "date")
        component    = _as_str(Project_config["component"], "component")
        line         = _as_str(Project_config["line"], "line")
        subUser      = _as_str(Project_config["subUser"], "subUser")

        # Derived paths
        Project_config["WELL"]    = project_home / "well"
        Project_config["SEISMIC"] = project_home / "seismics"
        Project_config["SITE_DATE_COMPONENT_LINE"] = Path(site) / date / component / line

        Project_config["DATA_SEISMIC"]      = Project_config["SEISMIC"] / "data"
        Project_config["DATA_SEISMIC_BIN"]  = Project_config["DATA_SEISMIC"] / Project_config["SITE_DATE_COMPONENT_LINE"] / "bin" / subUser
        Project_config["DATA_SEISMIC_SEGY"] = Project_config["DATA_SEISMIC"] / Project_config["SITE_DATE_COMPONENT_LINE"] / "segy" / subUser
        Project_config["DATA_SEISMIC_SU"]   = Project_config["DATA_SEISMIC"] / Project_config["SITE_DATE_COMPONENT_LINE"] / "su" / subUser
        Project_config["DATA_SEISMIC_TXT"]  = Project_config["DATA_SEISMIC"] / Project_config["SITE_DATE_COMPONENT_LINE"] / "txt" / subUser
        
        Project_config["GEOPSY"]  = Project_config["SEISMIC"] / "geopsy" / Project_config["SITE_DATE_COMPONENT_LINE"] / subUser 
        Project_config["GEOPSY_FORWARD_MODEL"]  = Project_config["GEOPSY"] / "dispersion_model" / "modes"

        self.paths = Project_config
        
        # Export only the derived ones you want as attributes
        self.export_as_attributes([
             "DATA_SEISMIC_BIN", "DATA_SEISMIC_SEGY",
             "DATA_SEISMIC_SU","DATA_SEISMIC_TXT",
             "GEOPSY_FORWARD_MODEL",
        ])
        return self.paths
    
    # Avoid accidentally overwriting
    # existing attributes/methods (like build, env, etc.).
    def export_as_attributes(self, keys):
      for k in keys:
        if k not in self.paths:
            raise KeyError(f"{k} not found in paths dict")

        # prevent clobbering existing methods/attrs
        if hasattr(self, k):
            raise AttributeError(f"Cannot export {k}: attribute already exists")

        setattr(self, k, self.paths[k])
        self._exported_keys.add(k)


def main() -> None:
    # Bootstrap import path only in the entry script (not inside the class)
    # Can be placed just before 
    # if __name__ == "__main__":
    #    main()

    seismic_unix_gui = _get_env_path("SeismicUnixGui")
    if str(seismic_unix_gui) not in sys.path:
        sys.path.insert(0, str(seismic_unix_gui))

    # from SUG_py.misc.local_user_constants import myProject_config

# permits bootstrapping
# See first method, which could be just above here
# as well
if __name__ == "__main__":
    main()
























# # folder = Path(os.environ.get("SeismicUnixGui"))
# # if folder is None:
# #     raise RuntimeError("SeismicUnixGui is not set")

# # Make Python look in that folder for imports 
# if folder not in sys.path: 
#     sys.path.insert(0, folder) 
    
# from SUG_py.misc.local_user_constants import myProject_config


# class myEnvironment:

#     def build_paths(self):
#         self.paths = dict(self.Project_config)

#         PROJECT_HOME = Path(self.paths["PROJECT_HOME"])
#         site      = self.paths["site"]
#         date      = self.paths["date"]
#         component = self.paths["component"]
#         line      = self.paths["line"]

#         self.paths.update({
#             "WELL": PROJECT_HOME / "well",
#             "SEISMIC": PROJECT_HOME / "seismics",
#             "SITE_DATE_COMPONENT_LINE":
#                 Path(site) / str(date) / str(component) / str(line),
#         })

#         self.paths["DATA_SEISMIC"] = self.paths["SEISMIC"] / "data"
#         self.paths["DATA_SEISMIC_BIN"] = self.paths["DATA_SEISMIC"] / "bin"



