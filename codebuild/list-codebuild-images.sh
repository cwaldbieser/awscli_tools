#! /bin/bash

AWS=aws
JELLO=jello

PROJECTS=$("$AWS" codebuild list-projects | "$JELLO" -lr '[entry for entry in _.projects]')

# shellcheck disable=2086
"$AWS" codebuild batch-get-projects --names $PROJECTS |\
    "$JELLO" '[{"name": project.name, "image": project.environment.image} for project in _.projects]'
