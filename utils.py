import random

from datetime import datetime, timedelta

def random_date(start: datetime, end: datetime) -> datetime:
	""" Returns a random datetime "%d-%m-%Y" between start and end. """
	delta = end - start
	int_delta = delta.days
	random_day = random.randrange(int_delta)
	date = start + timedelta(days=random_day)
	return date

def random_date_str(start: datetime, end: datetime) -> str:
	""" Returns a random date "%d-%m-%Y" between start and end. """
	return random_date(start, end).strftime("%d-%m-%Y")

def date_to_str(date: datetime) -> str:
	""" Formats date with "%d-%m-%Y". """
	return date.strftime("%d-%m-%Y")

def random_datetime(start: datetime, end: datetime) -> datetime:
	""" Returns a random datetime "%d-%m-%Y %H:%M:%S" between start and end. """
	delta = end - start
	int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
	random_second = random.randrange(int_delta)
	date = start + timedelta(seconds=random_second)
	return date

def random_datetime_str(start: datetime, end: datetime) -> str:
	""" Returns a random date "%d-%m-%Y %H:%M:%S" between start and end. """
	return random_datetime(start, end).strftime("%d-%m-%Y %H:%M:%S")

def datetime_to_str(time: datetime) -> str:
	""" Formats date with "%d-%m-%Y %H:%M:%S". """
	return time.strftime("%d-%m-%Y %H:%M:%S")
