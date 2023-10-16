#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <lcov_file> <sonarqube_xml_file>"
    exit 1
fi

lcov_file="$1"
sonarqube_xml_file="$2"

if [ ! -f "$lcov_file" ]; then
    echo "Error: lcov file not found: $lcov_file"
    exit 1
fi

# Create the SonarQube XML header
{
    echo '<?xml version="1.0"?>'
    echo '<coverage version="1">'
} > "$sonarqube_xml_file"

# Process the lcov file using awk for better performance
awk -F: '
    /^SF:/ {
        # Start a new source file section
        current_file = substr($0, 4)
        gsub(/"/, "\\&quot;", current_file)
        printf("  <file path=\"%s\">\n", current_file)
        next
    }
    /^DA:/ {
        # Process a coverage line (e.g., "DA:<lineNumber>,<executionCount>")
        line_number = substr($2, 1, index($2, ",") - 1)
        execution_count = substr($2, index($2, ",") + 1)
        if (execution_count > 0) {
            covered = "true"
        } else {
            covered = "false"
        }
        printf("    <lineToCover lineNumber=\"%s\" covered=\"%s\"/>\n", line_number, covered)
    }
    /^end_of_record/ {
        # End the current source file section
        print "  </file>"
    }
' "$lcov_file" >> "$sonarqube_xml_file"

# Close the XML document
echo '</coverage>' >> "$sonarqube_xml_file"

echo "Conversion completed. SonarQube XML report saved to $sonarqube_xml_file"
