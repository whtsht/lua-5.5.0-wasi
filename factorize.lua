local num, divisor, result = 360, 2, ""

while divisor * divisor <= num do
    while num % divisor == 0 do
        result = result .. divisor .. " "
        num = num // divisor
    end
    divisor = divisor + 1
end

if num > 1 then
    result = result .. num
end

print(result)
