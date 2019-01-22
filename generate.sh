#!/bin/bash

declare -a versions=(
        "latest"
        "7.2"
        "7.1"
        "7.0"
    )

basePath="generated"
buildScriptPath="build.sh"

# remove existing build script
if [ -f "$buildScriptPath" ]; then
    rm "$buildScriptPath"
fi

# add header and make executable
echo "#!/bin/sh" > "$buildScriptPath"
chmod +x "$buildScriptPath"

for version in "${versions[@]}"
do
    versionFolder="$basePath/$version"
    dockerFilePath="$versionFolder/Dockerfile"

    # make versionFolder path if it doesn't exist
    mkdir -p "$versionFolder"

    # remove existing Dockerfile if it exists
    if [ -f "$dockerFilePath" ]; then
        rm "$dockerFilePath"
    fi

    # generate new Dockerfile
    cat HEADER > "$dockerFilePath"
    cat Dockerfile.template | sed -e "s/\$VERSION/$version/g" >> "$dockerFilePath"

    echo "Generated $version"
    echo "docker build -t maloneweb/docker-php-development:$version generated/$version &" >> "$buildScriptPath"
done

echo "wait" >> "$buildScriptPath"
echo "Generated build script $buildScriptPath"
