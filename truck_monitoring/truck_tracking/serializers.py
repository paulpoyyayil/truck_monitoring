from rest_framework import serializers
from easy_load.models import log, user, driver, Drivertruck, load, TruckBooking, Chat_Replay, load_requset

class LoginUsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = log
        fields = '__all__'


class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = user
        fields = '__all__'
    def create(self, validated_data):
        return user.objects.create(**validated_data)


class DriverRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = driver
        fields = '__all__' 
    def create(self, validated_data):
        return driver.objects.create(**validated_data)



class DriverTruckSerializer(serializers.ModelSerializer):
    class Meta:
        model = Drivertruck
        fields = '__all__' 
    def create(self, validated_data):
        return Drivertruck.objects.create(**validated_data)


class UserLoadSerializer(serializers.ModelSerializer):
    class Meta:
        model = load
        fields = '__all__' 
    def create(self, validated_data):
        return load.objects.create(**validated_data)



class UserTruckBookingSerializer(serializers.ModelSerializer):
    class Meta:
        model = TruckBooking
        fields = '__all__' 
    def create(self, validated_data):
        return TruckBooking.objects.create(**validated_data)



class UserChatSerializer(serializers.ModelSerializer):
    class Meta:
        model = Chat_Replay
        fields = '__all__' 
    def create(self, validated_data):
        return Chat_Replay.objects.create(**validated_data)


class LoadRequestSerializer(serializers.ModelSerializer):
    class Meta:
        model = load_requset
        fields = '__all__' 
    def create(self, validated_data):
        return load_requset.objects.create(**validated_data)