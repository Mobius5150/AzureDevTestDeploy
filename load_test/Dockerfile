FROM jordi/ab

COPY ./tests /tests
WORKDIR /tests

RUN apt-get update
RUN apt-get install -y gnuplot

CMD ["bash", "loadtest.sh"]

