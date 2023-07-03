FROM python:3.8
COPY ./docs /docs
WORKDIR /docs
RUN pip install mkdocs
EXPOSE 8080
CMD ["mkdocs", "serve"]
