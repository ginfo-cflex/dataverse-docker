#!/bin/bash
if [ "$doiprovider" == "dara-4.0" ]; then
    curl http://localhost:8080/api/admin/datasetfield/load -X POST --data-binary @/opt/dv/deps/dara40.tsv -H "Content-type: text/tab-separated-values"
    /opt/glassfish4/glassfish/bin/asadmin add-library /opt/dv/deps/dara-dv-plugin/target/dara-plugin-1.0-SNAPSHOT-jar-with-dependencies.jar

    curl -X PUT -d $doiprovider http://localhost:8080/api/admin/settings/:DoiProvider
    curl -X PUT -d $authority http://localhost:8080/api/admin/settings/:Authority
    curl -X PUT -d $DOIseparator http://localhost:8080/api/admin/settings/:DoiSeparator
    /opt/glassfish4/glassfish/bin/asadmin create-jvm-options '-Ddoi.baseurlstring="$baseuri"'
    /opt/glassfish4/glassfish/bin/asadmin create-jvm-options -Ddoi.username="$login":-Ddoi.password="$password"
fi
