import { VenderDto } from "@/dtos/vender.dto";
import { VendersEntity } from "@/entities/venders.entity";
import AuthService from "@/services/auth.service";
import VenderService from "@/services/vender.service";

class AuthController {
    public authService = new AuthService();
    public vendrService = new VenderService();
    

    
  public signUp2 = async (venderDto: VenderDto): Promise<void> => {
    try {
        console.log("venderDto: ", venderDto);
      const signUpUserData: VendersEntity = await this.vendrService.addVender(venderDto);

      res.status(201).json({ data: signUpUserData, message: 'signup' });
    } catch (error) {
      next(error);
    }
  };
}