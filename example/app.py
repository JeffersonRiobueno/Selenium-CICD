import os

def print_username():
    # Obtener el valor de la variable de entorno USERNAME
    username = os.getenv('USERNAME')
    
    if username:
        print(f"El valor de USERNAME es: {username}")
    else:
        print("La variable de entorno USERNAME no está definida.") 
 
if __name__ == "__main__":
    print_username()



