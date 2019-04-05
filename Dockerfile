# Stage 0: Update apk
FROM python:3.7.2-alpine3.9 as base

RUN apk update && apk upgrade


# Stage 1: Add binaries for use during build
FROM base as build-base

RUN apk add --no-cache curl make zip


# Stage 2: Install Python requirements
FROM build-base as python-requirements

COPY ./requirements*.txt ./
RUN mkdir -p /wheels
RUN pip3 wheel -w /wheels -r /requirements_dev.txt virtualenv==16.0.0


# Stage 3: Test and build Python package
FROM build-base as build

WORKDIR /build

# copy requirements
COPY --from=python-requirements /wheels /wheels
COPY ./requirements*.txt ./
RUN pip3 install --no-index --find-links=/wheels -r ./requirements_dev.txt virtualenv==16.0.0

# test
COPY . ./
RUN make test

# build Python package
RUN make dist

# create virtual environment for runtime
RUN virtualenv /usr/local/dwolla_ci_python_example \
    && . /usr/local/dwolla_ci_python_example/bin/activate \
    && pip3 install --no-index --find-links=/wheels dist/dwolla*.tar.gz


# Stage 4: Build runtime
FROM base as runtime

# copy executable from build and put it in PATH
COPY --from=build /usr/local/dwolla_ci_python_example /usr/local/dwolla_ci_python_example
ENV PATH="/usr/local/dwolla_ci_python_example/bin:${PATH}"

ENTRYPOINT ["dwolla_ci_python_example"]
