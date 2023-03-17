#! /bin/bash

AWS=aws
JELLO=jello

${AWS} ec2 describe-instances | ${JELLO} -lr '\
results = []
for reservation in _.Reservations:
    for instance in reservation.Instances:
        if instance.State.Name != "running":
            continue
        tags = [
            tag 
            for tag in instance.Tags 
                if tag.Key == "Service" and tag.Value == "jsub"
        ]
        if len(tags) == 0:
            continue
        results.append(instance.InstanceId)
results'

