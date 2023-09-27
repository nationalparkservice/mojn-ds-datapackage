#Edits to EMLassemblyline generated metadata, using EMLeditor, to add NPS specific elements
#Step through the following tweaks
#Guidance: https://nationalparkservice.github.io/EMLeditor/articles/EMLeditor.html#a-minimal-workflow

my_metadata <- EML::read_eml("data/MOJN_DesertSprings_metadata.xml", from="xml")

my_meta2 <- set_cui(my_metadata, "PUBLIC")

# choose from "restricted", "public" and "CC0"
my_meta2 <- set_int_rights(my_meta2, "public")

my_meta2 <- set_language(my_meta2, "English")

park_units <- c("CAMO", "DEVA", "JOTR", "LAKE", "MOJA", "PARA")
my_meta2 <- set_content_units(my_meta2, park_units)

#a single producing unit:
my_meta2 <- set_producing_units(my_meta2, "MOJN")

#Add methods
my_meta2 <- EMLeditor::set_methods(my_meta2, "Field methods used are described in Springs in the Mojave Desert Network—Surface water monitoring at desert springs: Standard operating procedures version 1.0, available here: https://irma.nps.gov/DataStore/Reference/Profile/2256063. Specific methods include SOP 4: Spring Acceptance and Classification, SOP 5: Water Availability: Flow Condition, SOP 6: Water Availability: Data-Logging Sensors, SOP 7: Water Quality, SOP 8: Site Condition: Spring Vegetation, SOP 9: Site Condition: Invasive Plants, SOP 10: Site Condition: Disturbance, and SOP 11: Site Condition: Repeat Photographs.", force = TRUE, NPS = TRUE)
#Add ORCID for creators in the same order they are listed in txt file
my_meta2 <- EMLeditor::set_creator_orcids(my_meta2, 0009-0000-7542-8907, force = TRUE)
#DOI from precreated IRMA reference
my_meta2 <- EMLeditor::set_doi(my_meta2, 2300498, force = TRUE, NPS = TRUE)

#test EML file and continue only if you receive a result of TRUE
EML::eml_validate(my_meta2)

#Write changes back to your original metadata files
EML::write_eml(my_meta2, "data/MOJN_DesertSprings_metadata.xml")

#Copy XML and CSV files to data_packages folder
#Congruence check
dir <- here::here("data_packages", "MOJN_DesertSprings")
run_congruence_checks(dir)

#Upload to datastore
upload_data_package(dir)
