SERVER=223.5.5.5
NEWLINE=UNIX
SHELL=bash

raw:
	sed -e 's|^server=/\(.*\)/114.114.114.114$$|\1|' accelerated-domains.china.conf | grep -Ev -e '^#' -e '^$$' > accelerated-domains.china.raw.txt
	sed -e 's|^server=/\(.*\)/114.114.114.114$$|\1|' google.china.conf | grep -Ev -e '^#' -e '^$$' > google.china.raw.txt
	sed -e 's|^server=/\(.*\)/114.114.114.114$$|\1|' apple.china.conf | grep -Ev -e '^#' -e '^$$' > apple.china.raw.txt

adguardhome: raw
	cat google.china.raw.txt | tr "\n" "/" | sed -e 's|^|/|' -e 's|\(.*\)|[\1]$(SERVER)|' > google.china.adguardhome.conf
	cat accelerated-domains.china.raw.txt | tr "\n" "/" | sed -e 's|^|/|' -e 's|\(.*\)|[\1]$(SERVER)|' > accelerated-domains.china.adguardhome.conf
	cat apple.china.raw.txt | tr "\n" "/" | sed -e 's|^|/|' -e 's|\(.*\)|[\1]$(SERVER)|' > apple.china.adguardhome.conf
ifeq ($(NEWLINE),DOS)
	sed -i 's/\r*$$/\r/' accelerated-domains.china.adguardhome.conf google.china.adguardhome.conf apple.china.adguardhome.conf
endif

clean:
	rm -f {accelerated-domains,google,apple}.china.*.conf  {accelerated-domains,google,apple}.china.raw.txt
