#!/bin/bash

# This code has been written with the help of Redis documentation and ChatGPT

echo "Creating directories..."
# Create directories
for i in {7000..7005}; do
    mkdir -p $i
    echo "Created directory: $i"
done

echo "Creating redis.conf file with initial content..."
# Create redis.conf file with initial content
cat << EOF > redis.conf
# redis.conf file
port 7000
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
appendonly yes
EOF

echo "Updating port value in redis.conf and creating the file in each directory..."
# Update port value in redis.conf and create the file in each directory
for idx in {0..5}; do
    directory="700$idx"
    echo "Updating redis.conf in directory: $directory"
    sed "s/port 7000/port $directory/" redis.conf > "$directory/redis.conf"
done

echo "Removing unnecessary redis.conf in the current directory..."
# Remove unnecessary redis.conf in the current directory
rm -f redis.conf

echo "Setup completed!"

