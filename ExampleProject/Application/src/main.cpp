#include "MathLibrary.h"
#include <iostream>

int main()
{
    std::cout << "Hello World" << std::endl;

    double additionResault = MathLibrary::Arithmetic::Add(12, -3.1);

    double subtrationResault = MathLibrary::Arithmetic::Subtract(-2.13, 14);

    std::cout << "Resault of addition: " << additionResault << std::endl;
    std::cout << "Resault of subtration: " << subtrationResault << std::endl;
}
