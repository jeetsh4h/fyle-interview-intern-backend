FROM python:3.8.19-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git

# change github repo to the forked one, if required
RUN git clone https://github.com/fylein/fyle-interview-intern-backend

WORKDIR /app/fyle-interview-intern-backend

# set up environment
RUN pip install -r requirements.txt
ENV FLASK_APP=./core/server.py

### failed tests results in a non-zero exit code        ###
### therefore, no testing when building the application ###
# # run the tests
# RUN flask db upgrade -d core/migrations/
# RUN python -m pytest --cov
###########################################################

# # reset the db
# RUN rm core/store.sqlite3
# RUN flask db upgrade -d core/migrations/

# run the server, to test the application
CMD ["bash", "run.sh"]


# `docker build -t fyle-intern-backend:test .` to build the image
# `docker run -dp 127.0.0.1:7755:7755 fyle-intern-backend:test` to run the container
