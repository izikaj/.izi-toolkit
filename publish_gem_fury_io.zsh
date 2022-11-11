#/usr/bin/env bash
# Written by IzikAJ <izikaj@gmail.com>.

# use global value or load from secret file
FURY_IO_UPSTREAM=${FURY_IO_UPSTREAM:="$(cat fury.io.secret)"}

# publish private gem
# raw example:
# curl -F package=@writers_cms_v2-1.1.161.gem https://[SOME-UPLOAD-SECRET]@push.fury.io/[bucket]/
build_and_publish_gem() {
  echo "lets build gems..."
  for file in $(find *.gemspec -type f)
  do
    echo "\nbuild gemfile from:\n  $file"
    rm "/tmp/bapg.log" 2>/dev/null
    rm "/tmp/bapg.err.log" 2>/dev/null
    gem build $file 1>/tmp/bapg.log 2>/tmp/bapg.err.log

    result=$(cat "/tmp/bapg.log")
    if [ -z "$result" ]
    then
      echo "Not build!"
      cat "/tmp/bapg.err.log"
      continue
    fi

    echo "\nbuild results:\n$result"

    name="$(echo "$result" | grep Name | sed -e 's/[[:space:]]*Name:[[:space:]]*//')"
    rfile="$(echo "$result" | grep File | sed -e 's/[[:space:]]*File:[[:space:]]*//')"
    version="$(echo "$result" | grep Version | sed -e 's/[[:space:]]*Version:[[:space:]]*//')"

    if [ -z "$version" ]
    then
      echo "No taggable version!"
      continue
    fi

    git tag -a "v$version" -m "release v$version"
    git push origin "v$version"

    echo "\nupload $name@$version to fury.io..."
    curl -F package="@$rfile" "$FURY_IO_UPSTREAM"

    echo "\nremove artifacts..."
    rm "$rfile"
    echo "done!"
  done
}
