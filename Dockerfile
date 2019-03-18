# STAGE 0: Update APK #########################################################
FROM python:3.7.0-alpine3.8 as runtime-base

RUN apk update && apk upgrade


# STAGE 0.5: ADD BINARIES FOR USE DURING BUILD ################################
FROM runtime-base as build-base

RUN apk add --no-cache curl make zip


# STAGE 1: PYTHON REQUIREMENTS ################################################
FROM build-base as pip-reqs

ARG PIP_EXTRA_INDEX_URL=https://pypi.python.org/simple/
ARG PIP_INDEX_URL
ENV PIP_QUIET=true

COPY ./requirements*.txt ./
RUN mkdir -p /wheels
RUN pip3 wheel -w /wheels -r /requirements_dev.txt virtualenv==16.0.0


# STAGE 2: BUILD AND TEST #####################################################
FROM build-base as build

WORKDIR /build

# Requirements
COPY --from=pip-reqs /wheels /wheels
COPY ./requirements*.txt ./
RUN pip3 install --no-index --find-links=/wheels -r ./requirements_dev.txt virtualenv==16.0.0

# Test
COPY . ./
RUN make test

# Release
RUN make dist

# Virtualenv for runtime
RUN virtualenv /usr/local/dwolla_ci_example \
    && . /usr/local/dwolla_ci_example/bin/activate \
    && pip3 install --no-index --find-links=/wheels dist/dwolla*.tar.gz


# STAGE 3: RUNTIME ############################################################
FROM runtime-base as runtime

# Copy executable from build and put it on the PATH
COPY --from=build /usr/local/dwolla_ci_example /usr/local/dwolla_ci_example
ENV PATH="/usr/local/dwolla_ci_example/bin:${PATH}"

ENTRYPOINT ["dwolla_ci_example"]
