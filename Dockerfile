FROM golang:1.14-stretch as build

# Add everything
ADD . /usr/src/sriov-cni

RUN cd /usr/src/sriov-cni && \
    ./build 


FROM alpine:3.11
RUN apk --no-cache add bash
COPY --from=0 /usr/src/sriov-cni/bin/sriov /usr/bin/sriov

WORKDIR /

LABEL io.k8s.display-name="SR-IOV CNI"

ADD ./images/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
