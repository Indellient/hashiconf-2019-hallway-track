#!/bin/bash

GIT_COMMIT_REGEX="git commit -m \"*\""

git_added=0
git_commited=0
git_pushed=0
package_id=""

handle_input() {
    if [[ "$input" = "git add ." ]]; then
        git_added=1
    elif [[ "$git_added" -eq 1 ]] && [[ "$input" =~ $GIT_COMMIT_REGEX ]]; then
        git_commited=1
    elif [[ "$git_commited" -eq 1 ]] && [[ "$input" = "git push origin master" ]]; then
        git_pushed=1
    elif [[ -n "$input" ]]; then
        echo "Unknown command."
    fi
}

pipeline() {
    listen_to_vcs

    build

    run_tests

    package

    upload
}

listen_to_vcs() {
    spin 3
    padding
}

build() {
    spin 1
    echo "Building hello_world..."
    spin 4
    echo "Successfully built hello_word."
    padding
}

run_tests() {
    spin 1
    echo "Performing hello_world tests"
    for i in 1 2 3
    do
        test_name="hello_world.test_${i}"
        echo "Running test ${test_name}"
        spin 1
        echo "Test ${test_name} successful."
    done
    echo "All tests successful."
    padding
}

package() {
    spin 1
    echo "Packaging hello_world..."
    spin 4
    package_id="hello_world_$(openssl rand -hex 10)"
    echo "Produced package ${package_id}."
    padding
}

upload() {
    spin 1
    echo "Uploading ${package_id} to artifact store..."
    spin 4
    echo "Successfully uploaded ${package_id}."
    padding
}

padding() {
    echo "---------------"
}

spin() {
    delay=$1
    end=$((SECONDS+delay))
    local -a marks=( '/' '-' '\' '|' )
    while [[ $SECONDS -lt $end ]]; do
        printf '%s\r' "${marks[i++ % ${#marks[@]}]}"
        sleep 1
    done
}

while handle_input && [[ git_pushed -ne 1 ]]
do
    read input
done

pipeline
