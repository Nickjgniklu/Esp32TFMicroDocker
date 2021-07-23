FROM espressif/idf:v4.2.2
WORKDIR /var/app/tensorflowmicro/
RUN git clone https://github.com/tensorflow/tensorflow.git
WORKDIR /var/app/tensorflowmicro/tensorflow/
RUN git fetch --all --tags 
RUN	git checkout tags/v2.4.2 
RUN apt update
RUN apt-get install xxd
RUN make -f tensorflow/lite/micro/tools/make/Makefile TARGET=esp32 generate_hello_world_esp_project
