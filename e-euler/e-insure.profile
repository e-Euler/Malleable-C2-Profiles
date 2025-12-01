#
# Fiesta Exploit Kit traffic profile
#   http://malware-traffic-analysis.net/2014/04/05/index.html
#
# Author: @harmj0y
#

set sleeptime "30000"; # use a ~30s delay between callbacks
set jitter    "10"; # throw in a 10% jitter
set maxdns    "255";
set useragent "Mozilla/4.0 (Windows 7 6.1) Java/1.7.0_11";

http-get {

    set uri "/login.php /profile.php /help.php /contactus.php /services.php /logout.php /clients.php /adjust-claim.php";

    client {
        # mimic this Fiesta instance's header information
        header "Accept" "text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2";
        header "Connection" "keep-alive";

        # encode session metadata as close as we can to a Fiesta URI request
        metadata {
            netbios;
            append ";1;4;1";
            uri-append;
        }
    }

    server {
        header "Server" "redpen.com";
        header "X-Powered-By" "PHP/5.3.28";
        header "Content-Type" "application/octet-stream";
        header "Connection" "close";

        output {
            mask;
            print;
        }
    }
}

http-post {

    set uri "/login.php /profile.php /help.php /contactus.php /services.php /logout.php /clients.php /adjust-claim.php";

    client {
    
        # fake out a different user agent for the post back
        header "User-Agent" "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0"

        id {
            netbios;
            uri-append;
        }

        output {
            mask;
            print;
        }
    }

    server {
        header "Server" "redpen.com";
        header "Content-Type" "text/html";
        header "Connection" "close";

        output {
            mask;
            print;
        }
    }
}

