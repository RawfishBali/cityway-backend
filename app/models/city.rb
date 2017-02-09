# == Schema Information
#
# Table name: cities
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  latitude    :float            not null
#  longitude   :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  photo       :string
#

class City < ActiveRecord::Base

  has_many :merchants, through: :cities_merchants
  has_many :cities_merchants, dependent: :destroy

  has_many :events, through: :cities_events
  has_many :cities_events, dependent: :destroy

  has_and_belongs_to_many :advertisements, through: :advertisements_cities
  has_many :advertisements_cities, dependent: :destroy
  has_many :categories, through: :categories_cities
  has_many :categories_cities, dependent: :destroy
  has_one :around, dependent: :destroy
  has_one :commonplace, dependent: :destroy
  has_one :discover, dependent: :destroy
  has_one :utility, dependent: :destroy
  has_many :promos, dependent: :destroy

  validates_presence_of :name
  # validates_presence_of :description
  validates_presence_of :around
  validates_presence_of :commonplace
  validates_presence_of :discover
  validates_presence_of :utility

  geocoded_by :name
  after_validation :geocode
  after_create :execute_predifined_category

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results[1]
      obj.name    = geo.city
    end
  end

  mount_base64_uploader :photo, PhotoUploader

  accepts_nested_attributes_for :around, :commonplace, :discover, :utility,  allow_destroy: true

  def active_advertisements
    advertisements.where('( (start_date <= ? and end_date >= ?) )', Time.now, Time.now).group_by(&:position)
  end

  def home_active_advertisements
    advertisements.where('( (start_date <= ? and end_date >= ? and sections @> ? ) )', Time.now, Time.now, '{Home}').group_by(&:position)
  end

  def around_active_advertisements
    advertisements.where('( (start_date <= ? and end_date >= ? and sections @> ?) )', Time.now, Time.now, '{Intorno a te}').group_by(&:position)
  end

  def commonplace_active_advertisements
    advertisements.where('( (start_date <= ? and end_date >= ? and sections @> ?) )', Time.now, Time.now, '{Comune}').group_by(&:position)
  end

  def discover_active_advertisements
    advertisements.where('( (start_date <= ? and end_date >= ? and sections @> ?) )', Time.now, Time.now, '{Scopri}').group_by(&:position)
  end

  def utility_active_advertisements
    advertisements.where('( (start_date <= ? and end_date >= ? and sections @> ?) )', Time.now, Time.now, '{Utilità e Servizi}').group_by(&:position)
  end

  def parent_categories
    categories.where(parent_id: nil).order('Name ASC')
  end

  def sorted_categories
     categories.includes(:categories_cities).parent_categories.where('categories_cities.city_id = ? ',self.id).order('categories_cities.priority ASC')
  end

  def categories_with_merhcant
    city_category_id = City.find(self.id).merchants.map(&:category_id)
    ids = CategoriesCity.where('category_id in (?)', city_category_id).order('priority asc').map(&:category_id).uniq
    Category.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
  end

  def execute_predifined_category
    category_1 = Category.create(name: 'SHOPPING', predifined: true)

    category_1.subcategories << Category.create(name: 'ABBIGLIAMENTO', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ABBIGLIAMENTO BAMBINIE RAGAZZI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ABBIGLIAMENTO DANZA', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ABBIGLIAMENTO E ARTICOLI GESTANTI E NEONATI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ABBIGLIAMENTO INTIMO E BIANCHERIA', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ABITI DA LAVORO, DIVISE, INDUMENTI PROTETTIVI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ABITI DA SPOSA , CERIMONIA', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ARTIGIANATO TIPICO E ARTISTICO', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'BIANCHERIA ALBERGHI E COMUNITA', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'BIANCHERIA PER LA CASA', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'BIGIOTTERIA', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'BOUTIQUES E ALTA MODA', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'CALZATURE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'CALZE E COLLANT', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: "CANCELLERIA, MATERIALI PER L'UFFICIO", predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'CARTOLERIE, CARTOLIBRERIE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'CENTRI COMMERCIALI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'COMPRO ORO', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'COPISTERIE, LEGATORIE, CARTOTECNICHE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'CORNICI, ASTE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'EDICOLE, TABACCHERIE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ELETTRODOMESTICI, CASALINGHI, LISTE NOZZE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'ELETTRONICA, MULTIMEDIA, HI-TECH', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'GARDEN E VIVAI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'GIOCATTOLI, IDEE REGALO', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'GIOIELLERIE, OREFICERIE, OROLOGERIE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'HARDWARE, SOFTWARE E ACCESSORI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'LIBRERIE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'MACCHINE DA CUCIRE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: "MERCATINI DELL'USATO", predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'MERCERIE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'OTTICA E FOTO', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'PELLETTERIE, VALIGERIE,  ARTICOLI DA VIAGGIO', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'PIANTE E FIORI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'SIGARETTE ELETTRONICHE', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'STRUMENTI MUSICALI E ACCESSORI', predifined: true, parent_id: category_1.id)
    category_1.subcategories << Category.create(name: 'TELEFONIA E ACCESSORI', predifined: true, parent_id: category_1.id)






    category_2 = Category.create(name: 'MANGIARE E BERE', predifined: true)
    category_2.subcategories << Category.create(name: 'BAR, CAFFE', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'BIRRERIE, ENOTECHE', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'CATERING', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'GASTRONOMIE E ROSTICCERIE', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'GELATERIE E YOGURTERIE', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'PASTICCERIE', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'PIADINERIE', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'PIZZERIE', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'PIZZERIE AL TRANCIO', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'PUBS', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'RISTORANTI', predifined: true, parent_id: category_2.id)
    category_2.subcategories << Category.create(name: 'TRATTORIE', predifined: true, parent_id: category_2.id)



    category_3 = Category.create(name: 'RICETTIVITÀ', predifined: true)
    category_3.subcategories << Category.create(name: 'AGRITURISMI', predifined: true, parent_id: category_3.id)
    category_3.subcategories << Category.create(name: 'BED & BREAKFAST', predifined: true, parent_id: category_3.id)
    category_3.subcategories << Category.create(name: 'CAMPEGGI, OSTELLI', predifined: true, parent_id: category_3.id)
    category_3.subcategories << Category.create(name: 'COLONIE ESTIVE', predifined: true, parent_id: category_3.id)
    category_3.subcategories << Category.create(name: 'HOTEL, ALBERGHI, PENSIONI, RIFUGI', predifined: true, parent_id: category_3.id)
    category_3.subcategories << Category.create(name: 'STABILIMENTI BALNEARI ', predifined: true, parent_id: category_3.id)
    category_3.subcategories << Category.create(name: 'STABILIMENTI BALNEARI ', predifined: true, parent_id: category_3.id)


    category_4 = Category.create(name: 'SALUTE', predifined: true)
    category_4.subcategories << Category.create(name: 'ASSISTENZA SOCIALE, INFERMIERISTICA, DOMICILIARE', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'AMBULATORI, ANALISI CLINICHE', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'APPARECCHI ACUSTICI', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'ARTICOLI MEDICALI ED ELETTROMEDICALI', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'CASE DI CURA, DAY HOSPITAL', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'CLINICHE DEL SALE', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'DENTISTI', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'FARMACIE', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'ORTOPEDIE ED ARTICOLI MEDICOSANITARI', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'OTTICI', predifined: true, parent_id: category_4.id)
    category_4.subcategories << Category.create(name: 'SANITARIE', predifined: true, parent_id: category_4.id)


    category_5 = Category.create(name: 'BEAUTY, WELNESS, FITNESS', predifined: true)
    category_5.subcategories << Category.create(name: 'CENTRI ESTETICI, SOLARIUM', predifined: true, parent_id: category_5.id)
    category_5.subcategories << Category.create(name: 'CENTRI BENESSERE E SPA', predifined: true, parent_id: category_5.id)
    category_5.subcategories << Category.create(name: 'PALESTRE', predifined: true, parent_id: category_5.id)
    category_5.subcategories << Category.create(name: 'PARRUCCHIERI E ACCONCIATORI', predifined: true, parent_id: category_5.id)
    category_5.subcategories << Category.create(name: 'PROFUMERIE', predifined: true, parent_id: category_5.id)
    category_5.subcategories << Category.create(name: 'RICOSTRUZIONE UNGHIE', predifined: true, parent_id: category_5.id)


    category_6 = Category.create(name: 'SUPERMERCATI, ALIMENTARI, SPECIALITÀ', predifined: true)
    category_6.subcategories << Category.create(name: 'ALIMENTARI, SALUMERIE', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'ALIMENTAZIONE DIETETICA, BIOLOGICA, MACROBIOTICA', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'CAFFE', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'CASEIFICI, LATTERIE', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'DETERSIVI, ARTICOLI PER PULIZIE', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'FRUTTA E VERDURA', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'MACELLERIE', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'PANIFICI, FORNI', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'PERCHERIE', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'PESCE SURGELATO', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'PRODOTTI TIPICI', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'SENZA GLUTINE', predifined: true, parent_id: category_6.id)
    category_6.subcategories << Category.create(name: 'SUPERMERCATI', predifined: true, parent_id: category_6.id)



    category_7 = Category.create(name: 'BEVANDE, VINI, ALCOLICI', predifined: true)
    category_7.subcategories << Category.create(name: 'ACQUE MINERALI, BEVANDE, VINI, LIQUORI', predifined: true, parent_id: category_7.id)
    category_7.subcategories << Category.create(name: 'BIRRIFICI', predifined: true, parent_id: category_7.id)
    category_7.subcategories << Category.create(name: 'CANTINE', predifined: true, parent_id: category_7.id)
    category_7.subcategories << Category.create(name: 'DISTILLERIE', predifined: true, parent_id: category_7.id)
    category_7.subcategories << Category.create(name: 'ENOTECHE', predifined: true, parent_id: category_7.id)



    category_8 = Category.create(name: 'ANIMALI', predifined: true)
    category_8.subcategories << Category.create(name: 'ACQUARI', predifined: true, parent_id: category_8.id)
    category_8.subcategories << Category.create(name: 'ADDESTRAMENTO ANIMALI', predifined: true, parent_id: category_8.id)
    category_8.subcategories << Category.create(name: 'ALIMENTI ED ARTICOLI PER ANIMALI (domestici)', predifined: true, parent_id: category_8.id)
    category_8.subcategories << Category.create(name: 'ALLEVAMENTO ANIMALI', predifined: true, parent_id: category_8.id)
    category_8.subcategories << Category.create(name: 'VETERINARI', predifined: true, parent_id: category_8.id)


    category_9 = Category.create(name: 'CICLI E MOTORI', predifined: true)


    category_10 = Category.create(name: 'TEMPO LIBERO, SPORT, VACANZE ', predifined: true)
    category_10.subcategories << Category.create(name: 'ABBIGLIAMENTO E ARTICOLI EQUITAZONE ', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'ABBIGLIAMENTO E ARTICOLI SPORTIVI', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'AGENZIE IPPICHE, DI SCOMMESSE, LOTTERIE ', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'AGENZIE VIAGGI E TURISMO', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'ATTREZZATURE E ARTICOLI DA CAMPEGGIO', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'BRICOLAGE, FAI DA TE', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'CACCIA E PESCA', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'DISCOTECHE LOCALI NOTTURNI, SALE DA BALLO', predifined: true, parent_id: category_10.id)
    category_10.subcategories << Category.create(name: 'SALE GIOCHI, BILIARDI, BOWLING', predifined: true, parent_id: category_10.id)


    category_11 = Category.create(name: 'SERVIZI', predifined: true)
    category_11.subcategories << Category.create(name: 'AGENZIE DI SPETTACOLO, TEATRALI, CINEMATOGRAFICHE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AGENZIE E SCUOLE PER ATTRICI E FOTOMODELLE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AGENZIE IMMOBILIARI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AGENZIE INTERINALI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AGENZIE INTERMEDIAZIONE MOBILIARE ED IMMOBILIARE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AGENZIE INVESTIGATIVE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AGENZIE MATRIMONIALI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AMMINISTRAZIONI CONDOMINIALI E IMMOBILIARI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'ASSICURAZIONI E BROKER', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'ASSOCIAZIONI DI CATEGORIA', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'ASTE PUBBLICHE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'AVVOCATI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'CAMERA DI COMMERCIO INDUSTRIA ARTIGIANATO', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'CARTELLI, INSEGNE, TIMBRI, TARGHE, COPPE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'COMMERCIALISTI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'CONSORZIO AGRARIO', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'CORRIERI, TRASPORTATORI, LOGISTICA', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'DERATIZZAZIONE, DISINFESTAZIONE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'IMPRESE DI PULIZIE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'INFORTUNISTICA STRADALE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'LAVANDERIE E LAVANDERIE INDUSTRIALI ', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'ORGANIZZAZIONE RICEVIMENTI E BANCHETTI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'RIPARAZIONE ELETTRODOMESTICI, TV, HI-FI', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'SCUOLE GUIDA', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'STAMPA DIGITALE', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'STUDI DI ARCHITETTURA', predifined: true, parent_id: category_11.id)
    category_11.subcategories << Category.create(name: 'TRASLOCHI E FACCHINAGGIO', predifined: true, parent_id: category_11.id)


    category_12 = Category.create(name: 'ARREDAMENTO E MOBILIFICI', predifined: true)
    category_12.subcategories << Category.create(name: 'ANTIQUARI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'ARREDAMENTO IN GENERE, MOBILIFICI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'ARREDAMENTO IN STILE', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'ARREDAMENTO UFFICI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'ARREDAMENTOE D ARTICOLI ETNICI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'ARREDO BAGNO', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'ARREDO GIARDINI E DESTERNI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'ARREDO URBANO', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'CUCINE', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'MATERASSI, CUSCINI, RETI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'POLTRONE E DIVANI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'TAPPETI', predifined: true, parent_id: category_12.id)
    category_12.subcategories << Category.create(name: 'TENDAGGI, TENDE SOLE', predifined: true, parent_id: category_12.id)


    category_13 = Category.create(name: 'CASA, EDILIZIA E IMPIANTI', predifined: true)
    category_13.subcategories << Category.create(name: 'CAMINETTI, BARBEQUE, STUFE A PELLET', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'CANCELLI, PORTONI, AUTOMATISMI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'CARPENTERIE E FABBRI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'CARPENTERIE EDILI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'COLORI, SMALTI, CARTA DA PARATI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'COMBUSTIBILI, RISCALDAMENTO', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'CONTROSOFFITTATURE, CARTONGESSO', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'COPERTURE EDILI, TETTI, COIBENTAZIONI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'ELETTRICISTI, IMPIANTI ELETTRICI CIVILI E INDUSTRIALI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'ENERGIA SOLARE ALTERNATIVA', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'ESCAVAZIONI, DEMOLIZIONI, MOVIM. TERRA', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'FALEGNAMERIE', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'FERRAMENTA', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'GIARDINIERI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'IDRAULICI E TERMOIDRAULICI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'ILLUMINAZIONE', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'IMBIANCHINI E DECORATORI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'LATTONERIE', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'LEGNA DA ARDERE E PELLET', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'MATERIALI ED ATTREZZATURE EDILI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'PAVIMENTI, RIVESTIMENTI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'SERRAMENTI E INFISSI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'SPURGO POZZI NERI', predifined: true, parent_id: category_13.id)
    category_13.subcategories << Category.create(name: 'VETRERIE', predifined: true, parent_id: category_13.id)


    category_14 = Category.create(name: 'SICUREZZA', predifined: true)
    category_14.subcategories << Category.create(name: 'ANTIFURTI, ANTINCENDIO, DISPOSITIVI DI SICUREZZA', predifined: true, parent_id: category_14.id)
    category_14.subcategories << Category.create(name: 'ANTINFORTUNISTICA', predifined: true, parent_id: category_14.id)
    category_14.subcategories << Category.create(name: 'CARTELLI SEGNALATORI, ANTINFORTUNISTICI', predifined: true, parent_id: category_14.id)
    category_14.subcategories << Category.create(name: 'SICUREZZA SUL LAVORO(CORSI, VERIFICARE)', predifined: true, parent_id: category_14.id)


    category_15 = Category.create(name: "ATTIVITÀ STORICHE, INDUSTRIE STORICHE", predifined: true)
    category_15.subcategories << Category.create(name: "ATTIVITA' STORICHE", predifined: true, parent_id: category_15.id)
    category_15.subcategories << Category.create(name: 'INDUSTRIE STORICHE', predifined: true, parent_id: category_15.id)

    self.categories << [category_1 , category_2 , category_3 , category_4 ,category_5 ,category_6 ,category_7 ,category_8 ,category_9 ,category_10 ,category_11 ,category_12 ,category_13 ,category_14 ,category_15]

    arr_categories = self.categories.map(&:name)

    self.categories.where(name: arr_categories).each_with_index do |c,i|
      c.categories_cities.last.update(priority: i)
    end
  end

end
