#!/bin/bash

counter=0

while [ $counter -lt 42 ]; do
  let counter=counter+1
  
  # Extract the name, last_name from the file people.txt
  name=$(nl people.txt | grep -w $counter | awk '{print $2}' | awk -F ',' '{print $1}')
  last_name=$(nl people.txt | grep -w $counter | awk '{print $2}' | awk -F ',' '{print $2}')

  # Generate age between range and get first option
  age=$(shuf -i 30-35 -n 1)

  # Connect to the database container and insert the values into table
  mysql -u root -ptest1234 people -e "insert into register_people values ($counter, '$name', '$last_name', $age)"
  
  echo "$counter, $name, $last_name, $age was correctly inserted into database"
done