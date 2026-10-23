
#!/bin/bash
set -eu

echo "Running application tests..."

test -f index.html
grep -q "Welcome to Jenkins Pipeline" index.html
grep -q "built using a Jenkinsfile" index.html

echo "All application tests passed."
