# Pair: Enrique Luque

module Payroll_Helper
    def Round_Salary salary
        salary.round(2)
    end
end

module Payroll_Hourly
    include Payroll_Helper

    def Hourly hourly_rate, hours_worked
        Round_Salary hourly_rate * hours_worked
    end    
end

module Payroll_Salary
    include Payroll_Helper

    def Salary salary
        Round_Salary salary / 52.0
    end    
end

class Employee
    attr_reader :name, :email

    def initialize name, email
        @name = name
        @email = email
    end
end

class HourlyEmployee < Employee
    include Payroll_Hourly

    def initialize name, email, hourly_rate, hours_worked
        super name, email
        @hourly_rate = hourly_rate
        @hours_worked = hours_worked
    end

    def calculate_salary
        hourly_payment = Hourly @hourly_rate, @hours_worked
    end
end

class SalaryEmployee < Employee
    include Payroll_Salary

    def initialize(name, email, salary)
        super name, email
        @salary = salary
    end

    def calculate_salary
        daily_payment = Salary @salary
    end
end

class MultiPaymentEmployee < HourlyEmployee
    def initialize salary_employee, hourly_rate, hours_worked
        base_hours = 40
        super salary_employee.name,
              salary_employee.email,
              hourly_rate,
              hours_worked - base_hours
        @salary_employee = salary_employee
    end

    def calculate_salary
        weekly_base_payment = @salary_employee.calculate_salary
        weekly_hours_extra = super
        weekly_hours_extra = 0 if weekly_hours_extra < 0
        weekly_payment = weekly_base_payment + weekly_hours_extra
    end
end 

class Payroll
    include Payroll_Helper

    def initialize employees
        @employees = employees
    end

    def pay_employees
        # Should output how much we're paying each employee for this week and the total amount spent on payroll this week.
        total_weekly_salary = @employees.reduce(0) do |total_weekly_salary, employee|
            weekly_salary = employee.calculate_salary
            puts weekly_salary
            total_weekly_salary += weekly_salary + (weekly_salary * 0.18)
        end
        Round_Salary total_weekly_salary
    end
end

josh = HourlyEmployee.new 'Josh', 'nachoemail@example.com', 35, 50
nizar = SalaryEmployee.new 'Nizar', 'starcraftrulez@gmail.com', 1000000
ted = MultiPaymentEmployee.new SalaryEmployee.new('Ted', 'fortranr0x@gmail.com', 60000), 275, 55

employees = [josh, nizar, ted]

pay = Payroll.new employees
puts pay.pay_employees