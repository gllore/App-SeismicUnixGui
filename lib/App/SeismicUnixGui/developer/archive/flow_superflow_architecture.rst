
=============================
Flow and Superflow Architecture
=============================

.. note::
   This document provides an overview of the flow and superflow architecture, module relationships,
   and developer conventions. It is written in reStructuredText for Sphinx documentation systems.

Abbreviations
=============

+---------+-------------------------------------------------------------+
| Symbol  | Meaning                                                     |
+=========+=============================================================+
| `,`     | separates methods or subroutines within a module/package    |
+---------+-------------------------------------------------------------+
| `;`     | separates entire modules or packages                        |
+---------+-------------------------------------------------------------+
| `.pm`   | omitted when referencing module names                       |
+---------+-------------------------------------------------------------+
| `sgy`, `txt`, `bin`, `su` | data file extensions                      |
+---------+-------------------------------------------------------------+

Overview
========

There are two main flow types in the system:

1. **User-built flows**
2. **Pre-built “superflows”**

User-Built Flows
----------------

- Represented by four colors, each corresponding to its own module (``grey_flow``, ``pink_flow``, etc.).
- Diverge from their respective base modules such as ``grey_flow.pm``, ``pink_flow.pm``, etc.
- ``sunix_select.pm`` exclusively uses ``neutral_flow.pm``.
- Each color flow has an independent namespace, mostly isolated from other components.

Superflows
----------

- Diverge from user-built flows through ``pre_built_superflow.pm`` in the ``L_SU`` namespace.
- Use distinct logic for execution and file management.
- Share certain dialog and parameter structures with user-built flows, but have separate initialization and save behaviors.

Dialog and File Interaction
===========================

Run and Save Buttons
--------------------

Run and Save have independent logic paths:

+--------------+-----------------------------------+
| Flow Type    | Logic Path                        |
+==============+===================================+
| Superflows   | ``L_SU, run_button`` and ``L_SU, save_button`` |
+--------------+-----------------------------------+
| User-built   | Within color flow modules such as ``grey_flow.pm`` |
+--------------+-----------------------------------+

SaveAs, Data, and Flow Buttons
------------------------------

These use the path::

   L_SU, FileDialog_button

Superflow File Bindings
-----------------------

Superflows with file-opening capabilities use::

   L_SU, pre_built_superflows
   pre_built_big_stream->select()
   _FileDialog_button
   pre_built_big_stream,select,binding->set()  # binding occurs here

In ``file_dialog``::

   iFile->get_Path

retrieves the directory path that bindings depend on.

Developer Notes — Bindings
==========================

Bindings in User-Built Programs
-------------------------------

User-built programs that include bindings (e.g., **MB3**) often use ``sunix`` programs,
which locate files via ``_FileDialog_button``.

Each color flow module (``grey_flow.pm``, ``pink_flow.pm``) contains its own ``_FileDialog_button``.

Supported File Types
--------------------

+--------------------------+--------------------------------------------------+
| Category                 | Description                                      |
+==========================+==================================================+
| ``_Flow``                | User-built flow files                            |
+--------------------------+--------------------------------------------------+
| ``_Data`` or ``_Data_PL_SEISMIC`` | Seismic (``.su``), binary, parameter, and text files |
+--------------------------+--------------------------------------------------+
| ``_Path``                | Directories or superflow definitions             |
+--------------------------+--------------------------------------------------+

Common Questions
================

Q1. How is the FileDialog activated for a ``sunix`` program with a binding?
---------------------------------------------------------------------------

Some programs, such as ``segyread``, have bindings that automatically open directories containing SEG-Y files.
For directory definitions, refer to ``Project_config.pm``.

Q2. Differences Between “Save” Methods
--------------------------------------

+------------------+--------------------------+
| Flow Type        | Save Method              |
+==================+==========================+
| Superflows       | ``L_SU->save_button``    |
+------------------+--------------------------+
| User-built flows | ``color_flow.pm->save_button`` |
+------------------+--------------------------+

Save execution sequence::

   main
      └── L_SU
           └── color_flow.pm->save_button

Q3. How are colored listboxes selected (MB1 bindings)?
------------------------------------------------------

When **MB1** (left mouse button) is clicked on a colored listbox (grey, pink, green, or blue),
that flow becomes active::

   L_SUV0.X.C, _L_SU_flow_bindings(color, flow_select)
   L_SU->user_built_flows(flow_select)
   grey_flow->flow_select

Package Behavior Summary
========================

``whereami``
------------

- Identifies the current widget and its condition.
- Operates outside the main program namespace.
- Inherited by ``gui_history``.

``conditions_gui``
------------------

- Creates a private hash within the main program namespace.
- Enables or disables widgets.
- Tracks flow index.
- Allows modifications to incoming values.

``decisions``
-------------

- Evaluates conditions to automate logic within the namespace.

Configuration Management
========================

Superflows, big streams, and tools manage configuration files through internal libraries.

- Parameters are stored in arrays.
- External libraries (e.g., ``Config::Simple``) are deprecated.
- Some superflows maintain local configuration files such as ``iSpectralAnalysis.config``.

If modifying local configs, ensure that master configs are updated accordingly.

Superflow Call Hierarchy
========================

::

   Main
    └── _L_SU_superflows
         └── pre_built_superflow
              └── select
                   └── config_superflows
                        └── get_local_or_defaults
                             └── big_streams_param
                                  └── su_param
                                       └── readfiles.pm
                                            └── configs
                                                 └── param_widgets

- ``big_streams_param`` extends ``su_param``.
- ``su_param`` reads variables using ``readfiles.pm``.
- ``readfiles.pm`` loads configuration data and passes it to ``param_widgets``.

Adding Custom Parameters to Superflow GUI
=========================================

**Example:** Adding the ``geopsy`` parameter to the ``Project`` superflow.

Steps
-----

1. Locate the target configuration handler (``config_superflows`` or ``get_local_or_defaults``).
2. Add the parameter to the configuration array.
3. Update the corresponding ``.config`` file.
4. Ensure ``param_widgets`` recognizes the new parameter.
5. Rebuild or reload the GUI to verify changes.

