FROM ubuntu as builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei

RUN apt-get update -y && \
    apt-get install -y tzdata build-essential cmake libseccomp-dev

COPY [".", "/src/"]
WORKDIR /src
RUN mkdir build && \
    cd build/ && \
    cmake ..

FROM registry.cn-hangzhou.aliyuncs.com/onlinejudge/judge_server
COPY --from=builder /src/output/libjudger.so /usr/lib/judger/libjudger.so