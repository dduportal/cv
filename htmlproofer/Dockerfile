FROM alpine:3.11

RUN apk --no-cache --no-progress add \
    libcurl \
    ruby \
    ruby-bigdecimal \
    ruby-etc \
    ruby-ffi \
    ruby-json \
    ruby-nokogiri

RUN echo 'gem: --no-document' >> /etc/gemrc

RUN gem install html-proofer --version 3.14.1 --no-document -- --use-system-libraries

ENTRYPOINT ["htmlproofer"]
CMD ["--help"]
