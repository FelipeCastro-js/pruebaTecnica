using System;
using System.Linq;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Por favor digita la cadena de entrada");  // Leer la cadena de entrada
        string s = Console.ReadLine();
        
        if (0 > s.Length)
        {
            Console.WriteLine("Faltan caracteres");
            return;
        }

        if (s.Length > 1000)
        {
            Console.WriteLine("Limite de caracteres excedidos");
            return;
        }

        // Separar los caracteres alfanuméricos en tres arreglos diferentes
        char[] lower = s.Where(c => Char.IsLower(c)).OrderBy(c => c).ToArray();
        char[] upper = s.Where(c => Char.IsUpper(c)).OrderBy(c => c).ToArray();
        char[] digits = s.Where(c => Char.IsDigit(c)).OrderBy(c => c % 2 == 1 ? 0 : 1).ThenBy(c => c).ToArray();

        // Unir los arreglos ordenados en una sola cadena
        string result = new string(lower) + new string(upper) + new string(digits);

        Console.WriteLine("Impresion de cadena ordenada con las restricciones -> "+result);  // Imprimir la cadena ordenada
    }
}