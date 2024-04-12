# Use the latest official Solr image as the base
FROM solr:8.11.1


# Set the working directory in the container
RUN mkdir -p /var/lib/apt/lists/partial
RUN chmod 777 /var/lib/apt/lists/partial

# 
# RUN chmod 700 /var/lib/apt/lists/partial

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip \
    && apt-get clean

# Install pika library for RabbitMQ communication
RUN pip3 install pika

# Copy your Python script into the container
COPY rabbitmq_listener.py /usr/src/app/rabbitmq_listener.py

# Set environment variables for RabbitMQ connection details
# ENV RABBITMQ_HOST=localhost (tbd)
# ENV RABBITMQ_PORT=5672
# ENV RABBITMQ_USERNAME=guest
# ENV RABBITMQ_PASSWORD=guest
# ENV RABBITMQ_QUEUE=myqueue (tbd)

# Expose port 8983 for Solr HTTP requests
EXPOSE 8983

# Set the default command to start Solr
# CMD ["solr", "start", "-f"]