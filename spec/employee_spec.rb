require("spec_helper")

describe(Employee) do
  it("tells which division it belongs to") do
      division = Division.create({:description => "division"})
      employee = Employee.create({:name => "employee", :division_id => division.id})
    expect(employee.division()).to(eq(division))
  end
end
