#!/bin/bash
railroady -M -a -p -t -j --all-columns | dot -Tsvg > doc/models_complete.svg
railroady -M -a -p -t -j --all-columns -b | dot -Tsvg > doc/models_brief.svg
railroady -C -i | neato -Tsvg > doc/controllers_complete.svg
railroady -C -i -b | neato -Tsvg > doc/controllers_brief.svg
