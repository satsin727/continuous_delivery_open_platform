#!/bin/bash -v
# Change into your jenkins home.

cd /usr/share/tomcat6/.jenkins

# Add any new conf files, jobs, users, and content.
git add  *.xml jobs/*/config.xml plugins/*.hpi .gitignore

# Ignore things we don't care about
cat > .gitignore <<EOF
log
*.log
*.tmp
*.old
*.bak
*.jar
.*
updates/
jobs/*/builds
jobs/*/last*
jobs/*/next*
jobs/*/*.csv
jobs/*/*.txt
jobs/*/*.log
jobs/*/workspace
hudson.plugins.s3.S3BucketPublisher.xml
EOF

# Remove anything from git that no longer exists in jenkins.
git status --porcelain | grep '^ D ' | awk '{print $2;}' | xargs -r git rm

# And finally, commit and push
git commit -m 'Automated commit of jenkins configuration' -a
git push