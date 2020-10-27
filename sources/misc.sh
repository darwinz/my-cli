#!/bin/sh

######################################################
##############  Miscellaneous Functions ##############
######################################################

##  Get the weather in Salt Lake City and West Jordan (change zip code in URL querystring to get another city)
function weather()
{
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nweather\nmisc_weather\n\nGet the weather for a specified zip code\n  Usage example:  weather 84116"
        kill -INT $$
    fi

    echo "Zip code: ${1}"
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-${1}}" | perl -ne 's/&amp;deg;/°/g;/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';
}

##  Define a word using collinsdictionary.com
##  @argument  $* Any word to be defined
function define()
{
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\ndefine\nmisc_define\n\nDefine a word using collinsdictionary.com\n  @argument  \$* Any word to be defined\n  Usage example:  define someword"
        kill -INT $$
    fi

    echo -e "\n$@:\n"
    curl -s "http://www.collinsdictionary.com/dictionary/english/$*" | sed -n '/class="def"/p' | awk '{gsub(/.*<span class="def">|<\/span>.*/,"");print}' | sed "s/<[^>]\+>//g";
    echo ""
}
