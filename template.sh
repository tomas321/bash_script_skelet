#!/bin/bash

# GLOBALS

# TODO # example USAGE and HELP - change to your needs
USAGE="
USAGE: $0\t-x FILE [--arg] [-a NAME] [-b (aaa | bbb)] [-x FILE] [-v]
"
HELP="$USAGE
\t\t-a,--arga NAME\tdescription of arga
\t\t-b,--argb XXX\tdescription of argb
\t\t    --arg\tdescription of arg
\t\t-v\t\tverbose setting
\t\t-x,--argx FILE\tdescription of argx
\t\t-h,--help\tprints this help
"

# TODO # add all required arguments as so
declare -A REQUIRED_ARGS
REQUIRED_ARGS[-x]=1
# REQUIRED_ARGS[-b]=1

VERBOSE=0  # verbose logging

fail() {
    echo -e "error: $*"
    echo -e "   $USAGE"
    exit 1
}

warn() {
    echo -e "warning: $*"
}

debug() {
    [[ $VERBOSE -eq 1 ]] && echo -e "DEBUG: $*"
}

# TODO # change the ARGUMENTS LOOP
####################
## ARGUMENTS LOOP ##
####################
parse_args() {
    argvs=($@)

    while (( "$#" )); do
        case "$1" in
            -a|--arga)
                [[ ${REQUIRED_ARGS[-a]} -eq 1 ]] && REQUIRED_ARGS[-a]=0
                [[ $# -ge 2 ]] || fail "'-a': missing required parameter"
                name="$2"
                shift
                ;;
            -b|--argb)
                [[ ${REQUIRED_ARGS[-b]} -eq 1 ]] && REQUIRED_ARGS[-b]=0
                [[ $# -ge 2 ]] || fail "'-b': missing required parameter"
                shift

                case "$1" in
                    aaa)
                        echo processing aaa option
                        ;;
                    bbb)
                        echo processing bbb option
                        ;;
                    *)
                        [[ $# -gt 0 ]] && fail "'-b': unknown parameter '$1'"
                        ;;
                esac
                debug "read -b options"
                ;;
            --arg)
                # do something
                ;;
            -x|--argx)
                [[ ${REQUIRED_ARGS[-x]} -eq 1 ]] && REQUIRED_ARGS[-x]=0
                [[ $# -ge 2 ]] || fail "'-x': missing required parameter"
                [[ -e "$2" ]] || fail "'$2': file does not exist"
                file="$2"
                shift
                ;;
            -v|--verbose)
                VERBOSE=1
                ;;
            --help|-h)
                echo -e "$HELP" && exit 0
                ;;
            *)
                [[ $# -gt 0 ]] && fail "unknown argument '$1'"
                ;;
        esac
        shift
    done
    debug "parsed all arguemnts"
}

parse_args "$@"

# check if all required arguments were passed
for arg in "${!REQUIRED_ARGS[@]}"; do
    [[ ${REQUIRED_ARGS[$arg]} -eq 1 ]] && fail "missing required argument '$arg'"
done

debug "the file is '$file'"
debug "the name is '$name'"

##########
## MAIN ##
##########

# TODO # start the main execution 
echo MAIN processing

exit 0
