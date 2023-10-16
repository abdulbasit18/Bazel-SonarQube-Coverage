# Bazel-SonarQube-Coverage
A script that converts bazel coverage report to SonarQube accepted XML file

## SonarQube XML Report Generator

This script converts an LCOV coverage report to a SonarQube XML report.

### Usage

$0 <lcov_file> <sonarqube_xml_file>


Where:

* `<lcov_file>` is the path to the LCOV coverage report.
* `<sonarqube_xml_file>` is the path to the output SonarQube XML report.

### Example

$ ./lcov_to_sonar_xml.sh coverage.lcov sonar_report.xml

This will generate a SonarQube XML report called sonar_report.xml from the LCOV coverage report coverage.lcov.

Prerequisites
This script requires the following software to be installed:

LCOV
AWK
License
This script is licensed under the MIT License.

Contributing
Pull requests are welcome.

You may also want to add a section about the script's performance, as it uses awk for better performance. You could also mention that the script can be used in a CI/CD pipeline to generate SonarQube XML reports automatically.
