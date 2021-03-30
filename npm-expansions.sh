#!/usr/bin/env bash

npm-expansions() {
  case $1 in
    --help | -h)
      echo 'npm-expansions'
      echo
      echo 'USAGE'
      echo '  npm-expansions [uninstall|unload|update [version]|all [--comments]|--help|-h|--name|-n|--version|-v] [-- ...]'
      echo
      echo '  npm-expansions                         Default: random expansion'
      echo '  npm-expansions -- ...                  Sorts the result with ... first'
      echo '  npm-expansions all [--comments]        Prints all of the expansions (--comments keeps comments)'
      echo '  npm-expansions uninstall               Uninstalls the program'
      echo '  npm-expansions unload                  Unloads the program from the current shell'
      echo '  npm-expansions update [version]        Updates to version (default: latest)'
      echo '  npm-expansions --help, -h              Print this help output'
      echo '  npm-expansions --name, -n              Print the name'
      echo '  npm-expansions --version, -v           Tell the version'
      echo
      echo 'EXAMPLES'
      echo
      echo '  npm-expansions'
      echo '  npm-expansions all'
      echo '  npm-expansions --help'
      echo '  npm-expansions -v'
      echo '  npm-expansions --comments'
      echo '  npm-expansions all --comments -- '
      echo '  npm-expansions -- sed "s/N/a/g"'
      echo '  npm-expansions uninstall'
      echo '  npm-expansions unload'
      echo '  npm-expansions update 1.0'
      echo '  npm-expansions update'
      return
    ;;

    --version | -v)
      echo '1.1'
      return
    ;;

    --name | -n)
      echo 'npm-expansions'
      return
    ;;

    uninstall)
      rm ~/npm-expansions.sh
      cat ~/.bashrc | sed '/source ~\/npm-expansions\.sh/d' > ~/.bashrc
      unset -f npm-expansions
      return
    ;;

    unload)
      unset -f npm-expansions
      return
    ;;

    update)
      shift
      curl -s -o- https://raw.githubusercontent.com/Yash-Singh1/npm-expansions-cli/$([ -n "$1" ] && echo $1 || curl -s -o- https://api.github.com/repos/Yash-Singh1/npm-expansions-cli/releases/latest | grep tag_name | sed 's/  "tag_name": "//;s/",//')/npm-expansions.sh > ~/npm-expansions.sh
      source ~/npm-expansions.sh
      return
    ;;

  esac

  ALL=false
  if [ "$1" = "all" ]; then
    shift
    ALL=true
  fi

  NO_COMMENTS=true
  FOUND_SORT=false
  for arg in "$@"; do
    case $arg in
      --comments)
        shift
        NO_COMMENTS=false
      ;;

      --)
        shift
        FOUND_SORT=true
        break 2
      ;;

      *)
        echo "Unexpected argument: \"$arg\""
        return 1
      ;;

    esac
  done

  if [ "$ALL" = true ]; then
    if [ "$NO_COMMENTS" = true ]; then
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt | sed '/^#/d' | $@
      else
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt | sed '/^#/d'
      fi
    else
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt | $@
      else
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt
      fi
    fi
  else
    if [ "$NO_COMMENTS" = true ]; then
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt | sed '/^#/d' | $@ | sort -R | head -n 1
      else
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt | sed '/^#/d' | sort -R | head -n 1
      fi
    else
      if [ "$FOUND_SORT" = true ]; then
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt | $@ | sort -R | head -n 1
      else
        curl -s -o- https://unpkg.com/npm-expansions/expansions.txt | sort -R | head -n 1
      fi
    fi
  fi
}
