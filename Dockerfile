FROM alpine

LABEL maintainer=austozi

ENV PODDIE_TITLE=Podcasts \
	PODDIE_BASE_URL=http://localhost:5000 \
	PODDIE_DESCRIPTION="Podcasts generated from downloaded media" \
	PODDIE_ICON=http://localhost:5000/icon.png \
	PODDIE_UPDATE_INTERVAL=12h \
	PIP_BREAK_SYSTEM_PACKAGES=1 \
	S6_VERBOSITY=1

# Install base packages
ADD --chmod=777 \
	https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
	/usr/local/bin/yt-dlp
RUN \
	apk add --no-cache \
		aria2 \
		bash \
		coreutils \
		ffmpeg \
		jq \
		nginx \
		py3-pip \
		s6-overlay && \
	# pip dependencies
	pip install -U \
		niet \
		podcats

COPY --chmod=0755 /root/ /

ENTRYPOINT ["/init"]