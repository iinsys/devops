FROM python:3.12-slim

RUN addgroup --system app && adduser --system --ingroup app app
WORKDIR /opt/service
COPY --chown=app:app requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY --chown=app:app app.py .

USER app
CMD ["python", "app.py"]
