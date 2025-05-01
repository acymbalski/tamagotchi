#include "memory.h"
#include <Arduino.h>
#include "cpu.h"


uint8_t readMemory(uint16_t address)
{
  cpu_get_state(&cpuState);
  if (address < MEMORY_SIZE)
  {
    uint16_t original_address = address;
    // take memory address and divide it by two
    // if it has an odd address, read the lower nibble, otherwise the upper nibble
    // read correct value
    if ((address & 0x1) == 0)
    {
      // even address, read upper nibble
      address = address >> 1; // divide by 2
      return (cpuState.memory[address] & 0xF0) >> 4;
    }
    else
    {
      // odd address, read lower nibble
      address = address >> 1; // divide by 2
      return cpuState.memory[address] & 0x0F;
    }
    Serial.println("Reading memory");
    return cpuState.memory[address];
  }
  else
  {
    Serial.println("Error: Address out of bounds");
    return 0;
  }
}

void setMemory(uint16_t address, uint8_t value)
{

  cpu_get_state(&cpuState);

  if (address < MEMORY_SIZE)
  {
    uint16_t original_address = address;

    // divide address by 2 to get the correct memory location
    address = address >> 1;
    // take memory address and divide it by two
    // if it has an odd address, set the lower nibble, otherwise the upper nibble

    if ((original_address & 0x1) == 0)
    {
      // even address, set upper nibble
      value = (value << 4) | (cpuState.memory[address] & 0x0F);
      Serial.println("Even, setting upper nibble");
    }
    else
    {
      // odd address, set lower nibble
      value = (cpuState.memory[address] & 0xF0) | (value);
      Serial.println("Odd, setting lower nibble");
    }

    Serial.print("Updating memory from ");
    Serial.print(cpuState.memory[address], HEX);
    Serial.print(" to ");
    Serial.println(value, HEX);
    Serial.println("(Original memory address: 0x" + String(original_address, HEX) + ")");
    Serial.println("(New address: 0x" + String(address, HEX) + ")");
    cpuState.memory[address] = value;
    cpu_set_state(&cpuState);
    return;
  }
  else
  {
    Serial.println("Error: Address out of bounds");
    return;
  }
}