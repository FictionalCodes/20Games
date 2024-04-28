using Godot;

namespace Game1flappy.Scripts.Utils
{
    public delegate void NotifierDeligate<T>(T updatedValue);

    public class Notifier<[MustBeVariant]T>
    {
        public Notifier(T initialValue)
        {
            _value = initialValue;
        }

        private T _value;
        public T CurrentValue {
            get =>_value; 
            set 
            {
                _value = value;
                NotifyEvent?.Invoke(value);
            }
        }
        
        public event NotifierDeligate<T> NotifyEvent;
    }
}