ingredient_response = JSON.parse(RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"))

ingredients_names = []
for index in 0...ingredient_response['drinks'].size
    ingredients_names << ingredient_response['drinks'][index]['strIngredient1']
end

ingredients_info = []
for i in 0...ingredients_names.size
    if i == 100
        next
    end
    if i == 22 or i == 115
        if i == 22
            id = 37
        else
            id = 278
        end
        ingredient_info = JSON.parse(RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?iid=#{id}"))
        ingredients_info << ingredient_info['ingredients'][0]
    else
        ingredient_info = JSON.parse(RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/search.php?i=#{ingredients_names[i]}"))
        ingredients_info << ingredient_info['ingredients'][0]
    end
end

#save to db here
ingredients_info.each do |i|
    new_ing = Ingredient.new(name: i['strIngredient'], api_ingredient_id: i['idIngredient'], category: i['strType'], description: i['strDescription'])
    if new_ing.save!
        next
    else
        break
    end
end

drink_ids = []
i = 0
ingredients_names.each do |name|
    if i == 22 or i == 115
        i += 1
        next
    end
    ingredients_drinks = JSON.parse(RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{name}"))
    ingredients_drinks['drinks'].each do |drink|
        drink_ids << drink['idDrink']
    end
    i += 1
end

drink_ids = drink_ids.uniq
# drink_exclude = [17060, 17020, 13395, 14688, 12762, 15254, 17832, 11119]
# if drink_exclude.include?(drink_ids[i].to_i)
#     next
# end
cocktails = []
for i in 0...drink_ids.size
    drink_info = JSON.parse(RestClient.get("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink_ids[i]}"))
    cocktails << drink_info['drinks'][0]
end


# save drink info into db
cocktails.each do |c|
    new_cocktail = ApiCocktailInfo.new(api_cocktail_id: c['idDrink'], name: c['strDrink'], category: c['strCategory'], alcoholic: c['strAlcoholic'], glass: c['strGlass'], imageUrl: c['strDrinkThumb'], instructions: c['strInstructions'], videoUrl: c['strVideo'], ingredient_1: c["strIngredient1"], ingredient_2: c["strIngredient2"], ingredient_3: c["strIngredient3"], ingredient_4: c["strIngredient4"], ingredient_5: c["strIngredient5"], ingredient_6: c["strIngredient6"], ingredient_7: c["strIngredient7"], ingredient_8: c["strIngredient8"], ingredient_9: c["strIngredient9"], ingredient_10: c["strIngredient10"], ingredient_11: c["strIngredient11"], ingredient_12: c["strIngredient12"], ingredient_13: c["strIngredient13"], ingredient_14: c["strIngredient14"], ingredient_15: c["strIngredient15"], measurement_1: c["strMeasure1"], measurement_2: c["strMeasure2"], measurement_3: c["strMeasure3"], measurement_4: c["strMeasure4"], measurement_5: c["strMeasure5"], measurement_6: c["strMeasure6"], measurement_7: c["strMeasure7"], measurement_8: c["strMeasure8"], measurement_9: c["strMeasure9"], measurement_10: c["strMeasure10"], measurement_11: c["strMeasure11"], measurement_12: c["strMeasure12"],
    measurement_13: c["strMeasure13"], measurement_14: c["strMeasure14"], measurement_15: c["strMeasure15"])
    if new_cocktail.save!
        next
    else
        break
    end
end






# if c["strIngredient#{n}"] == "" or c["strIngredient#{n}"] == nil
#     break
# end

cocktails.each do |c|
    new_drink = Cocktail.new(api_cocktail_id: c['idDrink'], name: c['strDrink'], category: c['strCategory'], alcoholic: c['strAlcoholic'], glass: c['strGlass'], imageURL: c['strDrinkThumb'], instructions: c['strInstructions'], videoURL: c['strVideo'])
    if new_drink.save!
        for n in 1..15
            Ingredient.all.each do |i|
                if i.name.upcase == c["strIngredient#{n}"].upcase
                    CocktailIngredient.create(drink_id: new_drink.id, ingredient_id: i.id, measurement: c["strMeasure#{n}"])
                end
            end
        end
    else
        puts c['strDrink']
        break
    end
end


["14588", "15346", "15300", "17831", "17832", "17836", "11050", "17183", "11064", "17184", "11128", "17065", "11222", "11239", "11242", "12802", "11288", "11006", "11387", "11390", "11391", "11470", "11524", "14095", "17204", "11002", "11690", "17188", "11786", "11000", "11798", "17207", "11983", "11985", "12087", "12089", "12091", "12093", "12186", "12316", "16271", "12436", "12444", "17833", "11046", "13940", "17222", "17834", "17223", "17225", "17226", "17228", "11013", "11014", "11022", "11034", "11052", "17066", "11054", "11055", "13938", "17180", "11084", "17254", "11120", "17242", "11124", "11149", "17210", "17185", "11224", "17174", "17186", "17250", "17187", "11320", "11005", "11326", "11338", "11339", "11368", "11379", "17197", "17248", "11396", "17255", "11403", "11407", "11408", "11410", "17230", "11415", "11416", "11417", "11418", "11419", "11420", "11433", "11472", "12706", "11566", "16178", "11634", "11662", "11664", "11666", "17256", "11720", "11728", "17189", "13192", "11003", "11870", "17190", "17249", "11936", "11938", "11959", "11991", "17208", "17245", "12055", "12057", "17114", "17233", "12107", "12214", "12760", "17824", "12402", "12418", "12420", "17218", "12450", "12474", "17194", "17835", "17837", "11023", "17267", "16295", "17268", "13751", "17211", "17002", "11670", "11766", "15841", "17191", "11993", "12446", "17227", "17838", "17840", "15941", "11060", "11106", "11121", "17251", "11255", "11369", "11476", "11008", "17828", "17839", "12322", "11324", "11423", "12820", "11658", "12101", "12138", "12158", "12388", "12518", "11010", "11011", "15849", "12308", "12434", "16134", "11019", "17168", "16986", "14181", "11251", "17199", "11600", "11007", "15330", "11872", "12198", "17219", "16405", "14560", "11012", "17094", "13423", "16041", "15178", "12224", "15194", "11016", "11164", "11170", "17202", "16951", "11963", "17192", "12130", "12256", "17193", "11020", "11129", "11205", "11382", "11558", "11844", "11004", "17229", "11021", "17181", "17827", "12442", "14167", "15200", "17005", "13501", "16082", "11024", "11025", "11026", "11027", "13731", "11028", "14306", "16100", "14578", "16202", "11029", "13328", "13202", "11375", "17198", "11422", "11424", "12762", "13847", "13190", "14378", "14087", "15515", "15639", "17826", "15006", "14065", "12870", "15813", "14456", "12774", "12786", "17224", "11053", "17195", "11227", "17203", "13837", "17205", "11102", "17246", "12528", "11147", "16447", "16987", "11580", "11602", "11604", "17206", "11001", "15423", "16333", "16289", "11112", "11118", "13068", "16991", "16196", "17253", "16984", "12362", "178307", "12370", "13621", "14602", "17216", "17217", "16158", "14029", "17105", "16943", "15675", "12790", "15567", "14272", "15182", "14622", "16354", "17074", "13086", "12756", "15266", "14364", "14071", "16176", "11113", "11117", "11119", "17120", "16998", "14730", "12796", "11243", "14133", "17212", "14688", "17213", "17252", "11462", "13539", "17015", "14956", "14446", "13196", "11009", "16995", "13499", "13535", "16992", "13072", "17214", "15184", "13625", "12162", "13377", "12754", "16273", "12452", "12460", "16967", "15403", "16942", "16963", "11145", "12792", "11146", "11157", "11202", "13206", "12730", "12798", "12800", "12890", "12808", "12910", "12916", "12914", "12768", "12670", "12944", "17044", "12770", "13971", "12698", "12696", "12694", "12704", "12744", "12988", "12746", "13214", "12067", "13020", "13026", "12127", "13036", "15521", "13024", "12784", "14229", "13807", "13162", "16419", "15853", "13332", "15511", "17079", "14356", "13066", "14538", "14282", "14466", "16485", "14642", "12772", "13825", "17266", "13198", "17177", "14372", "17196", "17182", "17247", "14782", "11528", "11542", "15951", "15615", "17200", "12560", "12562", "14586", "11961", "11989", "11965", "11987", "17141", "13056", "13058", "17209", "17201", "15825", "12071", "14978", "12097", "17241", "15106", "12188", "12190", "12196", "12564", "16958", "12658", "15092", "14157", "12572", "15226", "13042", "17108", "12758", "17175", "13204", "12618", "17829", "12630", "12726", "14594", "12654", "17239", "17178", "17221", "17220", "12732", "12734", "12736", "12668", "12688", "14053", "13861", "12748", "12750", "12724", "16990", "12656", "12722", "12672", "12674", "12690", "12692", "12728", "12716", "12862", "12720", "12702", "12718", "17830", "12766", "17176", "12708", "12710", "12712", "12714", "12776", "14209", "12738", "15997", "12752", "13581", "15409", "15743", "16262", "12764", "12780", "14860", "12782", "12856", "14608", "12794", "12854", "13899", "12864", "12876", "14564", "14360", "15024", "15224", "12954", "13032", "14366", "14195", "13070", "13200", "15691", "16047", "13128", "13497", "13389", "15789", "13194", "16108", "14374", "14107", "13222", "178306", "13282", "16311", "13395", "15801", "13405", "13675", "15933", "15328", "13683", "16031", "13775", "16250", "16985", "14510", "14842", "15288", "14610", "17006", "13936", "15597", "14584", "17060", "17020", "17122", "15082", "15395", "17825", "14482", "15427", "14598", "14752", "14888", "15026", "17035", "15086", "15761", "17215", "17118", "16275", "17167", "16403", "17027", "17135", "178308", "15254"] 