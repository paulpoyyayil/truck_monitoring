import firebase_admin
from firebase_admin import credentials

cred = credentials.Certificate("C:/Users/paulp/Desktop/truck_monitoring/truck_monitoring/truck_tracking/firebase.json")

firebase_app = firebase_admin.initialize_app(cred)
