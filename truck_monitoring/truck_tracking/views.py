from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
from easy_load.models import log, user, driver, Drivertruck, load, TruckBooking, Chat_Replay, load_requset
from truck_tracking.serializers import LoginUsersSerializer, UserRegisterSerializer, DriverRegisterSerializer, DriverTruckSerializer, UserLoadSerializer, UserTruckBookingSerializer, UserChatSerializer, LoadRequestSerializer
from django.db.models import Q

# Create your views here.


# user registration

class UserRegisterAPIView(GenericAPIView):
    serializer_class = UserRegisterSerializer
    serializer_class_login = LoginUsersSerializer

    def post(self, request):
        
        login_id=''
        name = request.data.get('name')
        email = request.data.get('email')
        mobile = request.data.get('mobile')
        location = request.data.get('location')
        username = request.data.get('username')
        password = request.data.get('password')
        role = 'user'
        user_status = '0'


        if (log.objects.filter(username=username)):
            return Response({'message': 'Duplicate Username Found!'}, status = status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data = {'username': username, 'password':password, 'role':role})
            print(serializer_login)
        if serializer_login.is_valid():
            logs = serializer_login.save()
            login_id = logs.id
            print(login_id)
        serializer = self.serializer_class(data= {'name':name, 'email':email,'mobile':mobile,'location':location, 'login_id':login_id, 'status':user_status,'role':role})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data, 'message':'User registered successfully', 'success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors, 'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)



# driver registration

class DriverRegisterAPIView(GenericAPIView):
    serializer_class = DriverRegisterSerializer
    serializer_class_login = LoginUsersSerializer

    def post(self, request):
        
        login_id=''
        name = request.data.get('name')
        email = request.data.get('email')
        mobile = request.data.get('mobile')
        location = request.data.get('location')
        vehicle_status = request.data.get('vehicle_status')
        licence_no = request.data.get('licence_no')
        transport_from = request.data.get('transport_from')
        transport_to = request.data.get('transport_to')
        username = request.data.get('username')
        password = request.data.get('password')
        role = 'driver'
        driver_status = '0'


        if (log.objects.filter(username=username)):
            return Response({'message': 'Duplicate Username Found!'}, status = status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data = {'username': username, 'password':password, 'role':role})

        if serializer_login.is_valid():
            logs = serializer_login.save()
            login_id = logs.id
            print(login_id)
        serializer = self.serializer_class(data= {'name':name, 'email':email,'mobile':mobile,'location':location,'vehicle_status':vehicle_status,'licence_no':licence_no,'transport_from':transport_from,'transport_to':transport_to, 'login_id':login_id, 'status':driver_status,'role':role})
        print(serializer)
        if serializer.is_valid():
            print("hi")
            serializer.save()
            return Response({'data':serializer.data, 'message':'Driver registered successfully', 'success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors, 'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)


# login

class LoginAPIView(GenericAPIView):
    serializer_class = LoginUsersSerializer

    def post(self, request):
        vehicle_status=''
        u_id=''
        username = request.data.get('username')
        password = request.data.get('password')
        # role = request.data.get('role')
        logreg = log.objects.filter(username=username, password=password)
        if (logreg.count()>0):
            read_serializer = LoginUsersSerializer(logreg, many=True)
            for i in read_serializer.data:
                id = i['id']
                print(id)
                role = i['role']
                regdata=user.objects.all().filter(login_id=id).values()
                print(regdata)
                for i in regdata:
                     u_id = i['id']
                     name=i['name']
                     l_status=i['status']
                     print(u_id)
                regdata=driver.objects.all().filter(login_id=id).values()
                print(regdata)
                for i in regdata:
                     u_id = i['id']
                     name=i['name']
                     l_status = i['status']
                     vehicle_status = i['vehicle_status']
                     print(l_status)
                     print(u_id)
                
            return Response({'data':{'login_id':id,'username':username,'password':password,'role':role,'user_id':u_id,'l_status':l_status,'name':name,'vehicle_status':vehicle_status},'success': True, 'message':'Logged in successfully'}, status=status.HTTP_200_OK)       
        else:
            return Response({'data':'username or password is invalid', 'success': False, }, status = status.HTTP_400_BAD_REQUEST)


# view all users

class Get_All_User_APIView(GenericAPIView):
    serializer_class = UserRegisterSerializer
    def get(self, request):
        queryset = user.objects.all()
        if (queryset.count()>0):
            serializer = UserRegisterSerializer(queryset, many=True)
            return Response({'data': serializer.data, 'message':'All User Data Get', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available', 'success':False}, status=status.HTTP_400_BAD_REQUEST)


# single user view

class Single_User_APIView(GenericAPIView):
    def get(self, request, id):
        queryset = user.objects.get(pk=id)
        serializer =UserRegisterSerializer(queryset)
        return Response({'data': serializer.data, 'message':'single user data', 'success':True}, status=status.HTTP_200_OK)


# update user

class Update_UserAPIView(GenericAPIView):
    serializer_class = UserRegisterSerializer
    def put(self, request, id):
        queryset = user.objects.get(pk=id)
        print(queryset)
        serializer = UserRegisterSerializer(instance=queryset, data=request.data, partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'updated successfully', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something Went Wrong', 'success':False}, status=status.HTTP_400_BAD_REQUEST)


# view all users

class Get_All_Driver_APIView(GenericAPIView):
    serializer_class = DriverRegisterSerializer
    def get(self, request):
        queryset = driver.objects.all()
        if (queryset.count()>0):
            serializer = DriverRegisterSerializer(queryset, many=True)
            return Response({'data': serializer.data, 'message':'All Driver Data Get', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available', 'success':False}, status=status.HTTP_400_BAD_REQUEST)

# single driver view

class Single_Driver_APIView(GenericAPIView):
    def get(self, request, id):
        queryset = driver.objects.get(pk=id)
        serializer =DriverRegisterSerializer(queryset)
        return Response({'data': serializer.data, 'message':'single doctor data', 'success':True}, status=status.HTTP_200_OK)


# update driver

class Update_DriverAPIView(GenericAPIView):
    serializer_class = DriverRegisterSerializer
    def put(self, request, id):
        queryset = driver.objects.get(pk=id)
        print(queryset)
        serializer = DriverRegisterSerializer(instance=queryset, data=request.data, partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'updated successfully', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something Went Wrong', 'success':False}, status=status.HTTP_400_BAD_REQUEST)


# # Drivers with vehicle

class get_All_Drivers_With_Vehicle(GenericAPIView):
    serializer_class = DriverRegisterSerializer 
    def get(self,request):
        queryset = driver.objects.all().filter(Q(vehicle_status="Yes") | Q(vehicle_status="yes")).values()
        return Response({'data': queryset, 'message':'Fetched all Drivers With Vehicle', 'success':True}, status=status.HTTP_200_OK)


#  Drivers without vehicle

class get_All_Drivers_Without_Vehicle(GenericAPIView):
    serializer_class = DriverRegisterSerializer 
    def get(self,request):
        queryset = driver.objects.all().filter(Q(vehicle_status="No") | Q(vehicle_status="no")).values()
        return Response({'data': queryset, 'message':'Fetched all Drivers Without Vehicle', 'success':True}, status=status.HTTP_200_OK)



class Driver_Add_Vehicle_APIView(GenericAPIView):
    serializer_class = DriverTruckSerializer

    def post(self, request):
        drivers = request.data.get('driver')
        truck_name = request.data.get('truck_name')
        trucknumber = request.data.get('trucknumber')
        truckfrom = request.data.get('truckfrom')
        truckto = request.data.get('truckto')
        load_capacity = request.data.get('load_capacity')
        truck_status = "0"

        data=driver.objects.all().filter(id=drivers).values()
        for i in data:
            d_name=i['name']


        serializer = self.serializer_class(data= {'driver':drivers,'driver_name':d_name, 'truck_name':truck_name,'trucknumber':trucknumber,'truckfrom':truckfrom,'truckto':truckto,'load_capacity':load_capacity,'status':truck_status})
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'Truck Added successfully', 'success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors, 'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)


# all truck data added bu driver

class Get_All_Truck_Added_By_Driver_APIView(GenericAPIView):
    serializer_class = DriverTruckSerializer
    def get(self, request):
        queryset = Drivertruck.objects.filter(status="0")
        if (queryset.count()>0):
            serializer = DriverTruckSerializer(queryset, many=True)
            return Response({'data': serializer.data, 'message':'All Trucks Added by Driver Data Get', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available', 'success':False}, status=status.HTTP_400_BAD_REQUEST)


# driver view truck added by him

class Single_Truck_Added_By_Driver_APIView(GenericAPIView):
    def get(self, request, id):
        queryset = Drivertruck.objects.get(driver=id)
        serializer =DriverTruckSerializer(queryset)
        return Response({'data': serializer.data, 'message':'single Trucks Added by Driver data', 'success':True}, status=status.HTTP_200_OK)


# updation of trucks added by drivers

class Update_Truck_Added_By_Driver_APIView(GenericAPIView):
    serializer_class = DriverTruckSerializer
    def put(self, request, id):
        queryset = Drivertruck.objects.get(driver=id)
        print(queryset)
        serializer = DriverTruckSerializer(instance=queryset, data=request.data, partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'updated successfully', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something Went Wrong', 'success':False}, status=status.HTTP_400_BAD_REQUEST)


# delete vehicle

class Delete_TruckAPIView(GenericAPIView):
    def delete(self, request, id):
        delmember = Drivertruck.objects.get(pk=id)
        delmember.delete()
        return Response({'message':'Truck Deleted successfully',  'success':True}, status=status.HTTP_200_OK)



class User_Add_Load_APIView(GenericAPIView):
    serializer_class = UserLoadSerializer

    def post(self, request):
        users = request.data.get('user')
        load_description = request.data.get('load_description')
        load_from = request.data.get('load_from')
        load_to = request.data.get('load_to')
        load_quantity = request.data.get('load_quantity')
        load_status = "0"

        data=user.objects.all().filter(id=users).values()
        for i in data:
            u_name=i['name']


        serializer = self.serializer_class(data= {'user':users,'username':u_name, 'load_description':load_description,'load_from':load_from,'load_to':load_to,'load_quantity':load_quantity,'status':load_status})
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'Load Added successfully', 'success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors, 'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)




class Get_All_Load_APIView(GenericAPIView):
    serializer_class = UserLoadSerializer
    def get(self, request):
        queryset = load.objects.filter(status="0")
        if (queryset.count()>0):
            serializer = UserLoadSerializer(queryset, many=True)
            return Response({'data': serializer.data, 'message':'All Load Data Get', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available', 'success':False}, status=status.HTTP_400_BAD_REQUEST)


# driver view truck added by him

class Single_load_APIView(GenericAPIView):
    def get(self, request, id):
        queryset = load.objects.get(user=id)
        serializer =UserLoadSerializer(queryset)
        return Response({'data': serializer.data, 'message':'single load data', 'success':True}, status=status.HTTP_200_OK)


# updation of trucks added by drivers

class Update_Load_APIView(GenericAPIView):
    serializer_class = UserLoadSerializer
    def put(self, request, id):
        queryset = load.objects.get(id=id)
        print(queryset)
        serializer = UserLoadSerializer(instance=queryset, data=request.data, partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'updated successfully', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something Went Wrong', 'success':False}, status=status.HTTP_400_BAD_REQUEST)



class Delete_LoadAPIView(GenericAPIView):
    def delete(self, request, id):
        delmember = load.objects.get(pk=id)
        delmember.delete()
        return Response({'message':'Load Deleted successfully',  'success':True}, status=status.HTTP_200_OK)



class TruckBookingAPIView(GenericAPIView):
    serializer_class = UserTruckBookingSerializer

    def post(self, request):
        u_name=""
        truck_name=""
        driver_name=""
        load_quantity=""

        users = request.data.get('user')
        drivers = request.data.get('driver')
        trucks=request.data.get('truck')
        loads = request.data.get('load')
        starting = request.data.get('starting')
        ending = request.data.get('ending')
        date = request.data.get('date')

        booking_status="0"
        
        booking = TruckBooking.objects.filter(truck=trucks, user=users )
        if booking.exists():
            return Response({'message':'Already Booked','success':False}, status=status.HTTP_400_BAD_REQUEST)

        else:
            data=Drivertruck.objects.all().filter(id=trucks).values()
            for i in data:
                print(i)
                truck_name=i['truck_name']
                driver_name=i['driver_name']
                i['status'] = "1"
                Drivertruck.objects.filter(id=trucks).update(status="1")

            dta=user.objects.all().filter(id=users).values()
            for i in dta:
                print(i)
                u_name=i['name']

            da=load.objects.all().filter(id=loads).values()
            for i in da:
                print(i)
                load_quantity=i['load_quantity']
                i['status'] = "1"
                load.objects.filter(id=loads).update(status="1")

                
            
                

            serializer = self.serializer_class(data= {'user':users,'driver':drivers,'username':u_name,'truck':trucks,'truck_name':truck_name,'driver_name':driver_name,'load':loads,'load_quantity':load_quantity,'starting':starting,'ending':ending,'date':date,'status':booking_status})
            print(serializer)
            if serializer.is_valid():
                print("hi")
                serializer.save()
                return Response({'data':serializer.data,'message':'Truck Booked successfully', 'success':True}, status = status.HTTP_201_CREATED)
            return Response({'data':serializer.errors,'message':'Invalid','success':False}, status=status.HTTP_400_BAD_REQUEST)




class Cancel_BookingAPIView(GenericAPIView):
    def delete(self, request, id):
        delmember = TruckBooking.objects.filter(pk=id)
        driver_name = delmember.values_list('driver_name', flat=True).first()
        delmember.delete()

        Drivertruck.objects.filter(driver_name=driver_name).update(status="0")

        return Response({'message': 'Booking Cancelled successfully', 'success': True}, status=status.HTTP_200_OK)



class UsersSingleBookingAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = TruckBooking.objects.filter(user=id).values()
        # serializer =UserTruckBookingSerializer(queryset)
        return Response({'data': queryset, 'message':'single user booking data', 'success':True}, status=status.HTTP_200_OK)


class diversSingleBookingAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = TruckBooking.objects.filter(driver=id).values()
        # serializer =UserTruckBookingSerializer(queryset)
        return Response({'data': queryset, 'message':'single driver bokking data', 'success':True}, status=status.HTTP_200_OK)



class Driver_Accept_booking_APIView(GenericAPIView):
    def post(self, request, id):
        serializer_class = UserTruckBookingSerializer
        user = TruckBooking.objects.get(pk=id)
        user.status = 1
        user.save()
        serializer = serializer_class(user)
        return Response({'data':serializer.data,'message':'Driver Approved Booking', 'success':True}, status=status.HTTP_200_OK)



class Reject_BookingAPIView(GenericAPIView):
    def delete(self, request, id):
        delmember = TruckBooking.objects.filter(pk=id)
        driver_name = delmember.values_list('driver', flat=True).first()
        delmember.delete()

        Drivertruck.objects.filter(id=driver_name).update(status="0")

        return Response({'message': 'Booking Rejected successfully', 'success': True}, status=status.HTTP_200_OK)




class UserChatAndReplayAPIView(GenericAPIView):
    serializer_class = UserChatSerializer

    def post(self, request):
        users = request.data.get('user')
        drivers = request.data.get('driver')
        chat = request.data.get('chat')
        date = request.data.get('date')
        chat_status="0"


        dta=user.objects.all().filter(id=users).values()
        for i in dta:
            print(i)
            u_name=i['name']


        dta=driver.objects.all().filter(id=drivers).values()
        for i in dta:
            print(i)
            d_name=i['name']


        serializer = self.serializer_class(data= {'user':users, 'driver':drivers,'username':u_name,'drivername':d_name,'chat':chat,'date':date,'chat_status':chat_status})
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'Chat Added successfully', 'success':True}, status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors, 'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)



class DriverViewChatAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = driver.objects.all().filter(pk=id).values()
        print(queryset)
        for i in queryset:
            d_id = i['id']
            print('///////////',d_id)
        instance = Chat_Replay.objects.filter(driver=d_id).values()
        print("======",instance)
        # serializer = UserChatSerializer(instance)
        return Response({'data': instance, 'message':'chat  data', 'success':True}, status=status.HTTP_200_OK)



class Update_ChatReply_APIView(GenericAPIView):
    serializer_class = UserChatSerializer
    def put(self, request, id):
        queryset = Chat_Replay.objects.get(id=id)
        print(queryset)
        serializer = UserChatSerializer(instance=queryset, data=request.data, partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data, 'message':'Reply Added successfully', 'success':True}, status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something Went Wrong', 'success':False}, status=status.HTTP_400_BAD_REQUEST)



class UserViewChatAndReplyAPIView(GenericAPIView):
    def get(self, request, id):
        queryset = user.objects.all().filter(pk=id).values()
        print(queryset)
        for i in queryset:
            d_id = i['id']
            print('///////////',d_id)
        instance = Chat_Replay.objects.filter(user=d_id).values()
        print("======",instance)
        # serializer = UserChatSerializer(instance)
        return Response({'data': instance, 'message':'chat  data', 'success':True}, status=status.HTTP_200_OK)




class LoadRequestAPIView(GenericAPIView):
    serializer_class = LoadRequestSerializer

    def post(self, request):
        load_from=''
        load_to=''
        load_quantity=' '
        users = request.data.get('user')
        drivers = request.data.get('driver')
        loads = request.data.get('load')
        load_status="0"

        load_requests = load_requset.objects.filter(load=loads, user=users)
        if load_requests.exists():
            return Response({'message':'Already Requested','success':False}, status=status.HTTP_400_BAD_REQUEST)

        else:



            dta=user.objects.all().filter(id=users).values()
            for i in dta:
                print(i)
                u_name=i['name']


            dta=driver.objects.all().filter(id=drivers).values()
            for i in dta:
                print(i)
                d_name=i['name']


            da=load.objects.all().filter(id=loads).values()
            for i in da:
                print(i)
                load_from=i['load_from']
                load_to=i['load_to']
                load_quantity=i['load_quantity']
                i['status'] = "1"
                load.objects.filter(id=loads).update(status="1")


            serializer = self.serializer_class(data= {'user':users, 'driver':drivers,'load':loads,'username':u_name,'drivername':d_name,'load_from':load_from,'load_to':load_to,'load_quantity':load_quantity,'status':load_status})
            print(serializer)
            if serializer.is_valid():
                serializer.save()
                return Response({'data':serializer.data, 'message':'Load Requested successfully', 'success':True}, status = status.HTTP_201_CREATED)
            return Response({'data':serializer.errors, 'message':'Failed','success':False}, status=status.HTTP_400_BAD_REQUEST)



class User_Accept_Load_Request_APIView(GenericAPIView):
    def post(self, request, id):
        serializer_class = LoadRequestSerializer
        user = load_requset.objects.get(pk=id)
        user.status = 1
        user.save()
        serializer = serializer_class(user)
        return Response({'data':serializer.data,'message':'User Accept Request', 'success':True}, status=status.HTTP_200_OK)


class Users_View_load_Request_APIView(GenericAPIView):
    def get(self, request, id):
        queryset = load_requset.objects.filter(user=id,status="0").values()
        # serializer =UserTruckBookingSerializer(queryset)
        return Response({'data': queryset, 'message':' All Users view Load Request', 'success':True}, status=status.HTTP_200_OK)



class Drivers_View_load_Request_APIView(GenericAPIView):
    def get(self, request, id):
        queryset = load_requset.objects.filter(driver=id,status="0").values()
        # serializer =UserTruckBookingSerializer(queryset)
        return Response({'data': queryset, 'message':'All Drivers View Load Request  ', 'success':True}, status=status.HTTP_200_OK)



class PaymentAPIView(GenericAPIView):
    serializer_class = UserTruckBookingSerializer

    def post(self, request, id):
        amount = request.data.get('amount')
        payment_date = request.data.get('payment_date')

        data = TruckBooking.objects.filter(user=id)  # Use filter() without first()

        if data:
            data.update(amount=amount, payment_date=payment_date)  # Update all objects in the queryset

            truck_ids = data.values_list('truck_id', flat=True)  # Get a list of truck IDs

            Drivertruck.objects.filter(id__in=truck_ids).update(status="0")  # Update status of matching truck IDs

            serializer = self.serializer_class(data, many=True)  # Serialize all objects in the queryset
            return Response({'data': serializer.data, 'message': 'Payment successful', 'success': True},
                            status=status.HTTP_201_CREATED)
        else:
            return Response({'message': 'Invalid request', 'success': False}, status=status.HTTP_400_BAD_REQUEST)


