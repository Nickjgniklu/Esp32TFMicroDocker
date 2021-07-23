FROM espressif/idf:v4.2.2
WORKDIR /var/app/tensorflowmicro/
RUN git clone https://github.com/tensorflow/tensorflow.git
RUN git clone https://github.com/Nickjgniklu/Esp32TFMicroDocker.git
WORKDIR /var/app/tensorflowmicro/tensorflow/
RUN git fetch --all --tags 
RUN	git checkout tags/v2.4.2 
RUN apt update
RUN apt-get install xxd
RUN cp -f ../Esp32TFMicroDocker/esp32_makefile.inc tensorflow/lite/micro/tools/make/targets/esp32_makefile.inc
RUN make -f tensorflow/lite/micro/tools/make/Makefile TARGET=esp32 generate_hello_world_esp_project
WORKDIR /var/app/tensorflowmicro/tensorflow/tensorflow/lite/micro/tools/make/gen/esp32_xtensa-esp32/prj/hello_world/esp-idf/components/tfmicro/
RUN cp -r  ./third_party/flatbuffers/include/flatbuffers/ ./
RUN cp -r ./third_party/gemmlowp/fixedpoint/ ./
RUN cp -r ./third_party/gemmlowp/internal/ ./
RUN cp -r ./third_party/kissfft/ ./
RUN cp -r ./third_party/ruy/ruy/ ./
RUN echo "#define TF_LITE_USE_GLOBAL_MIN" | cat - ./tensorflow/lite/kernels/internal/min.h
RUN echo "#define TF_LITE_USE_GLOBAL_MAX" | cat - ./tensorflow/lite/kernels/internal/max.h
RUN mkdir /var/app/tensorflowmicro/output
RUN mkdir /var/app/tensorflowmicro/output/tensorflowmicro
RUN cp -r ./ /var/app/tensorflowmicro/output/tensorflowmicro
WORKDIR /var/app/tensorflowmicro/output
