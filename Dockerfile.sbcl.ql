ARG VERSION

FROM common-lisp-sbcl:${VERSION}

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        libffi-dev \
        libssl-dev \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN wget http://beta.quicklisp.org/quicklisp.lisp

RUN sbcl --no-sysinit --no-userinit --non-interactive \
        --load ./quicklisp.lisp \
        --eval "(quicklisp-quickstart:install)" \
        --eval "(ql::without-prompting (ql:add-to-init-file))"

WORKDIR /root/common-lisp

ADD swank-server.lisp .

CMD ["sbcl", "--load", "swank-server.lisp"]
