#!/bin/bash


# Prompt the user for the number of iterations
read -p "Enter the number of iterations: " num_iterations

# Retrieve and print the first four lines of curl output for 10.0.0.3
echo "Output for 10.0.0.3:"
curl_output=$(curl -s "http://10.0.0.3:8080/turtle/status" | head -n 4)
echo "$curl_output"
echo "---------------------------------------"


# Check if the input is a valid number
if ! [[ "$num_iterations" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a valid number."
    exit 1
fi

for ((i = 1; i <= num_iterations; i++)); do
    echo "Output for 10.0.$i.1:"
    curl_output=$(curl -s "http://10.0.$i.1:8080/turtle/status")
    echo "$curl_output"
    echo "---------------------------------------"
done
